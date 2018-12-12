library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addrDecoder is
	generic(ADDR_WIDTH : integer;
			POW2_ADDR_WIDTH : integer);
	port(address : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
		 bitmask : out std_logic_vector(POW2_ADDR_WIDTH - 1 downto 0));
end addrDecoder;

architecture behavioral of addrDecoder is

	signal bitmsk: std_logic_vector(POW2_ADDR_WIDTH - 1 downto 0);
	signal empty: std_logic_vector(POW2_ADDR_WIDTH - 1 downto 0):= (others => '0');

begin
	decoder: process(address)
	begin
		bitmsk <= empty;
		bitmsk(to_integer(unsigned(address))) <= '1';
	end process;

	bitmask <= bitmsk;
	
end behavioral;
