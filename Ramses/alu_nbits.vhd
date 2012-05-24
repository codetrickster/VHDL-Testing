----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:36:36 05/11/2012 
-- Design Name: 
-- Module Name:    alu_nbits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_nbits is
    Port ( X : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : in  STD_LOGIC_VECTOR (7 downto 0);
           opcode : in  INSTR_TYPE;								-- Operation to be done in the ALU
           output : out  STD_LOGIC_VECTOR (7 downto 0);	-- Result of the operation
			  NZC : out  STD_LOGIC_VECTOR (2 downto 0));		-- Refresh the condition codes
end alu_nbits;

architecture Behavioral of alu_nbits is
	-- Register to hold the value of the sum/subtraction. There is one bit more
	-- to refresh the carry flag
	signal temp_reg : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
begin
	-- Clear the output
	output <= temp_reg(7 downto 0);
	
	-- Possible instructions that can be done in the ALU
	with opcode select
						-- Arithmetic operations
		temp_reg <= X(7 downto 0) + Y(7 downto 0) when ADD,	-- Addition operation
					   X(7 downto 0) - Y(7 downto 0) when SUB,   -- Subtraction
						-- Logic operations
						X(7 downto 0) AND Y(7 downto 0) when ANDPOP,	-- And operation
						X(7 downto 0) OR  Y(7 downto 0) when OROP,	-- Or operation
						NOT X(7 downto 0) when NOTOP, 					-- Invert bits
						NOT X(7 downto 0) + 1 when NEG,					-- A number's complement written in 2's complement
						"00" & X(7 downto 1) when SHR,					-- Shift right operation. The shift op. concatenates
																					-- the double zeros because the temp_reg has 8 bits
																					-- and uses only 7 bits of the input register
						"0" & X(7 downto 0) when LDR,						-- Load op.
						"000000000" when others;
		-- Refreshing flags
		-- Carry flag
		NZC(0) <= '0' when temp_reg(8) = '0' else '1';
		
		-- Zero flag
		NZC(1) <= '0' when temp_reg(7 downto 0) = x"00" else '1';
		
		-- Negative flag
		NZC(2) <= '0' when temp_reg(7) = '0' else '1';
end Behavioral;