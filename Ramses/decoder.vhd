----------------------------------------------------------------------------------
-- 
-- Ramses's decoder unit
--
-- Each word read from memory has 8-bits wide. The Ramses's instructions indicate
-- which register will be used, which address method will be used and which instruction
-- the ALU will perform.
--
-- The msbits of the read word indicate which instruction will be done, i. e.,
-- bits 7 to 4 indicate the respective instruction.
--
-- Bits 3 to 2 indicate which register will be used.
--
-- Bits 1 to 0 indicate which adress method will be used for that instruction
-- 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
	Port ( instr_in : in  STD_LOGIC_VECTOR(7 downto 0);	-- Instruction read from memory through MDR	);
			 opcode : out  INSTR_TYPE;								-- Code of the instruction that the ALU will perform
			 reg_sel : out  REG_TYPE;								-- Selection register signal
			 addr_method : out  ADDR_METHOD_TYPE );			-- Signal to control unit that indicates which address method are going to be used
end decoder;

architecture Behavioral of decoder is

begin
	-- Register selection
	reg_sel <= REG_A when instr_in(3 downto 2) = "00" else	-- Register A selected
				  REG_B when instr_in(3 downto 2) = "01" else	-- Register B selected
				  REG_X when instr_in(3 downto 2) = "10" else	-- Register X selected
				  NONE;														-- Error, invalid instruction
	
	-- Instruction decodification
	opcode <= NOP   when instr_in(7 downto 4) = "0000" else
				 STR   when instr_in(7 downto 4) = "0001" else
				 LDR   when instr_in(7 downto 4) = "0010" else
				 ADD   when instr_in(7 downto 4) = "0011" else
				 OROP  when instr_in(7 downto 4) = "0100" else
				 ANDOP when instr_in(7 downto 4) = "0101" else
				 NOTOP when instr_in(7 downto 4) = "0110" else
				 SUB   when instr_in(7 downto 4) = "0111" else
				 JMP   when instr_in(7 downto 4) = "1000" else
				 JN    when instr_in(7 downto 4) = "1001" else
				 JZ    when instr_in(7 downto 4) = "1010" else
				 JC    when instr_in(7 downto 4) = "1011" else
				 JSR   when instr_in(7 downto 4) = "1100" else
				 NEG   when instr_in(7 downto 4) = "1101" else
				 SHR   when instr_in(7 downto 4) = "1110" else
				 HLT   when instr_in(7 downto 4) = "1111" else
				 INVALID_INSTR;		-- Invalid intruction
	
	-- Address mode selection
	addr_method <= DIR   when instr_in(1 downto 0) = "00" else
						INDIR when instr_in(1 downto 0) = "01" else
						IMED  when instr_in(1 downto 0) = "10" else
						INDEX;		-- 'when' can't be used because it's the last combination
						

end Behavioral;

