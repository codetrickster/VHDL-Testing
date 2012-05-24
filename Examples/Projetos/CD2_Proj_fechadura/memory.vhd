LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

component altdpram
generic (
  width: natural := ;
  widthad: natural :=;
);
port(
  data: in std_logic_vector(width-1 downto 0) := (others => '1');
  rdaddress: in std_logic_vector(widthad-1 downto 0);
  q: out std_logic_vector(width-1 downto 0);
  wren: in std_logic	
);
end component;