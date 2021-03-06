library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ROrgPrSimLib;
use ROrgPrSimLib.proc_config.all;

entity ram is
	generic(
		NUM_ELEMENTS      : integer;
		LOG2_NUM_ELEMENTS : integer;
		ELEMENT_WIDTH     : integer);
	port(
		clk               : in  std_logic;
		address           : in  std_logic_vector( LOG2_NUM_ELEMENTS - 1 downto 0 );
		writeEn           : in  std_logic;
		writeData         : in  std_logic_vector( ELEMENT_WIDTH - 1 downto 0 );
		readEn            : in  std_logic;
		readData          : out std_logic_vector( ELEMENT_WIDTH - 1 downto 0 );
		ramElements_debug : out ram_elements_type);
end ram;

architecture behavioral of ram is

	signal ramElements : ram_elements_type := (others => (others => '0'));

begin

write:process(clk)
begin
	if clk'event and clk='1' then
		if writeEn='1' then
			ramElements(to_integer(unsigned(address))) <= writeData;
		end if;
	end if;
end process;


read:process(clk)
begin
	if clk'event and clk='1'  then
		if readEn='1' then
			readData <= ramElements(to_integer(unsigned(address)));
		end if;
	end if;
end process;

	ramElements_debug <= ramElements;

end behavioral;
