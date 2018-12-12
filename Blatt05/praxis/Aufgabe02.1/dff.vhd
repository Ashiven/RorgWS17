library ieee;
use ieee.std_logic_1164.all;

entity dff is
	port(
		clk : in  std_logic;
		D   : in  std_logic;
		Q   : out std_logic);
end dff;

architecture behavioral of dff is
begin

clock:process(clk)
begin
	if(clk'event and clk='1') then
	Q <= D;
	end if;
end process;
	
end behavioral;
