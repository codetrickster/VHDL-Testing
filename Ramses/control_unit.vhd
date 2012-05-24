----------------------------------------------------------------------------------
-- 
-- Ramses's control unit
-- 
-- That control unit manages the entire processor, i.e., it sends all signals that are
-- needed to update registers, condition codes, read & write memory signals and so on.
--
-- The instructions that come from decoder unit can be divided in 3 categories:
-- 	1º) Logic instructions that are performed over the registers, ie, they don't access
-- 		 the memory to execute the instruction since the data is already in the register.
--			 These instructions are NOT, NEG & SHR.
--		2º) Logic and arithmetic instructions that are performed over one register and one memory address.
--			 These kind of instructions need to access the memory. Due to the slow speed of the memory,
--			 one more cycle is needed until the data be ready on the MDR (memory data register).
--		3º) Jump instructions need to access the memory since the control unit need to know to where the PC
--			 will point. These instructions can be conditional or unconditional, ie, depending on the condition
--			 code and the flag, the jump instruction can become a NOP instruction. The instructions are 
--			 JMP (unconditional jump), JN (jump on negative), JC (jump on carry), JZ (jump on zero) and JSR ( 
--			 jump subroutine).
--
-- The control unit receives the instruction that are going to be done, if it is valid, and sends all signals.
-- Besides that, the control unit also receives the clock (to change its state since it's a FSM), reset signal
--	(signal that clear the machine such as PC, and so on), the register that is going to be used, since the register
-- data may be changed by instructions and the address method, the fundamental part of control unit.
--
-- The control unit analyses which address mode is used, since it specifies where is the operand. The adress method
-- also control how many cycles an instruction will take to be performed due to number of memory accesses.
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

entity control_unit is
	Port ( clk_in : 	in   STD_LOGIC;				-- Clock signal
			 rst_in :	in   STD_LOGIC;				-- Reset signal
			 opcode_in : in  INSTR_TYPE;			-- Decoded instruction from DECODER
			 reg_in : 	in  REG_TYPE;					-- Selected register
			 addr_method_in : in  ADDR_METHOD;	-- Address method
			 wr_enable : out  STD_LOGIC;			-- Load signal that enables memory writing
			 loadRA : 	out  STD_LOGIC;				-- Load signal to refresh register data
			 loadRB : 	out  STD_LOGIC;				-- Load signal to refresh register data
			 loadRX :	out  STD_LOGIC;				-- Load signal to refresh register data
			 loadMAR : 	out  STD_LOGIC;				-- Load signal to refresh memory adress in 'memory address register'
			 loadMDR : 	out  STD_LOGIC;				-- Load signal to refresh read data from memory in 'memory data register'
			 loadIR : 	out  STD_LOGIC;				-- Load signal for Instruction register
			 loadPC : 	out  STD_LOGIC;				-- Load signal for Program counter
			 loadNZ :	out  STD_LOGIC;				-- Load signal to refresh negative and zero flags
			 loadC : 	out  STD_LOGIC;				-- Load signal to refresh carry flag
			 loadRM : 	out  STD_LOGIC;				-- Load signal to read from memory
			 flagNZC : 	out  STD_LOGIC_VECTOR(2 downto 0);	-- Condition flags
			 selRX : 	out  STD_LOGIC_VECTOR(1 downto 0);		-- Register X selection signal
			 selPC : 	out  STD_LOGIC_VECTOR(1 downto 0);		-- Signal to select when the program counter is incremented or it receives a memory value
			 selMDR : 	out  STD_LOGIC_VECTOR(1 downto 0));	-- Signal to select memory data register data source
end control_unit;

architecture Behavioral of control_unit is
	-- FSM states definition
	type STATE_TYPE is ( SRC_MAR, SRC_STA_MAR, SRC_READ, SRC_IR,	-- MAR <- PC | Stabilize MAR load |
																						-- Read memory and increment PC |
																						-- Put instruction on IR
								DECODE,												-- Decode the instruction
								EXEC_MEM,											-- Execute instructions that use memory
								EXEC_REG,											-- Execute instructions that only use registers
								EXEC_MEM_DIR1,										-- Read from memory e defines next state based on address method
								EXEC_MEM_DIR2,										-- Put MDR data on MAR to find the operand on memory
								EXEC_MEM_DIR3,										-- Read the operand
								EXEC_MEM_DIR4										-- Refresh condition codes and point to the next instruction
	
							 );
	-- Variables that hold the current and the next state
	signal current_state, next_state : STATE_TYPE;
	
	-- Defining the instruction type based on the DECODER
	signal inst_reg, inst_memory, inst_jmp : STD_LOGIC;
begin
	-- Classifying instructions in arithmethic, logic and jumps, besides the memory access
	-- If the instruction happens only in the register
	inst_reg <= '1' when opcode_in = NEG 	 or
								opcode_in = NOTOP or
								opcode_in = SHR
						else '0';
						
	-- If the instruction uses the memory
	inst_mem <= '1' when opcode_in = ADD   or
								opcode_in = SUB 	 or
								opcode_in = ANDOP or
								opcode_in = OROP	 or
								opcode_in = LDR	 or
								opcode_in = STR
						else '0';
	
	-- If any jump is done, other operations need to be done
	inst_jmp <= '1' when opcode_in = JMP	 or
								opcode_in = JN 	 or
								opcode_in = JC 	 or
								opcode_in = JZ 	 or
								opcode_in = JSR
						else '0';
	
	-- Initial state and state transition
	proc_trans: process( clk_in, rst_in )
	begin
		-- Set the FSM to its initial state when rst_in is active
		if ( rst_in = '1' ) then
			current_state <= SRC_MAR;
		else
			-- State change
			if ( rising_edge( clk_in ) ) then
				current_state <= next_state;
			end if;
		end if;
	
	end process;
	-- Process the states
	proc_state: process ( current_state, inst_reg, inst_mem, inst_jmp, reg_in, addr_method_in )
	begin
		-- Defines what each state will do and the next states
		case current_state is
			
			-- First stage of the search of an instruction. Set to zero all load signals except MAR.
			when SRC_MAR =>
				loadMAR 		<= '1';
				loadRA 		<= '0';
				loadRB 		<= '0';
				loadRX 		<= '0';
				loadIR 		<= '0';
				loadMDR 		<= '0';
				loadPC 		<= '0';
				loadNZ 		<= '0';
				loadC 		<= '0';
				loadRM 		<= '0';
				wr_enable 	<= '0';
				
				next_state	<= SRC_STA_MAR;
			
			-- Set to zero MAR load signal since the MAR is connected to the MDR and when a memory reading is done,
			-- the data goes to MDR.
			when SRC_STA_MAR =>
				loadMAR 		<= '0';
				next_state 	<= SRC_READ;
			
			-- Read the memory data and put it onto MDR and increment the PC.
			when SRC_READ =>
				loadMDR 		<= '1';
				loadPC 		<= '1';
				selPC			<= "11";
				
				next_state	<= SRC_IR;
			
			-- Send the instruction to instruction register, since the IR is connected to MDR
			when SRC_IR =>
				loadMDR		<= '0';
				loadPC		<= '0';
				loadIR		<= '1';
				
				next_state	<= DECODE;
				
				
			-- Define what is state is going to set based on the instruction decodification by the DECODER
			when DECODE =>
				loadIR <= '0';
				
				-- The next state depends on the type of the instruction
				if ( inst_jmp = '1' ) then
					next_state <= EXEC_JMP;
				elsif ( inst_reg = '1' ) then
					next_state <= EXEC_REG;
				elsif ( inst_mem = '1' ) then
					loadMAR <= '1';
					-- The data source of the MDR can be the PC, the MDR or the sum of RX with the MDR
					-- These are the options:
					--		1) "00" => Data from PC
					--		2) "01" => Data from MDR
					--		3) "10" => Data from MDR + RX
					--		1) "11" => Invalid option
					selMAR <=  "00";
					next_state <= EXEC_MEM;
				else
					-- Invalid instruction
					next_state <= SRC_MAR;
				end if;
		end case;
	end process;

end Behavioral;

