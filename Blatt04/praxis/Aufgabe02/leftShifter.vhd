library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity leftShifter is
	generic(
		WIDTH 			: integer;
		SHIFT_AMOUNT 	: integer
	);
	port(
		number 			: in std_logic_vector(WIDTH - 1 downto 0);
		shiftedNumber 	: out std_logic_vector(WIDTH - 1 downto 0)
	);
end leftShifter;

architecture behavioral of leftShifter is
begin

	-- Beschreibung hier einfügen
	
end behavioral;
