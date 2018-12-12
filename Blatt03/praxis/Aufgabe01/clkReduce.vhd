library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkReduce is
	generic( divisor : integer := 1 );
	port( clk_in  : in  std_logic;
	      clk_out : out std_logic );
end clkReduce;

architecture behavioral of clkReduce is
begin

	-- Taktteiler-Beschreibung hier einfügen

end behavioral;
