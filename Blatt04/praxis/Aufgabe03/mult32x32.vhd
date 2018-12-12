library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult32x32 is
    port(
		a 	: in std_logic_vector(31 downto 0);
		b 	: in std_logic_vector(31 downto 0);
		y 	: out std_logic_vector(63 downto 0)
	);
end mult32x32;

architecture structural of mult32x32 is
begin
    
    -- Strukturbeschreibung hier einfügen

end structural;
