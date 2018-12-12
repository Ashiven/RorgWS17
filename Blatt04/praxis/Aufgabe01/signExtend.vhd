library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signExtend is
	generic(
		INPUT_WIDTH 	: integer;
		OUTPUT_WIDTH 	: integer
	);
	port(
		number 			: in signed(INPUT_WIDTH - 1 downto 0);
		signExtNumber 	: out signed(OUTPUT_WIDTH - 1 downto 0)
	);
end signExtend;

architecture behavioral of signExtend is
begin
	
	-- Beschreibung hier einfügen
	
end behavioral;
