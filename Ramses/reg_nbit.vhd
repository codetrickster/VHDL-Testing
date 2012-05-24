----------------------------------------------------------------------------------
-- Company: 
-- Description of a generic register of nbits
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncosamment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_8bit is
	 Generic ( n : integer := 8 );		-- The default register size is 8 bits
    Port ( input : in  STD_LOGIC_VECTOR (n-1 downto 0);
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (n-1 downto 0));
end reg_8bit;

architecture Behavioral of reg_8bit is
	-- Signal to hold the value (the register)
	signal data_temp : STD_LOGIC_VECTOR (n-1 downto 0);
begin
	-- Process signals
	process (clk, load, clear)
	begin
		if ( clear = '1' ) then					-- Clear the register data
			data_temp <= ( others => '0' );
		elsif ( rising_edge( clk ) ) then	-- Updates the register data
			if ( load = '1' ) then
				data_temp <= input;				-- Stores the data into the register
			end if;
		end if;
	end process;
	
	-- Returns the register data (parallel)
	output <= data_temp;

end Behavioral;
