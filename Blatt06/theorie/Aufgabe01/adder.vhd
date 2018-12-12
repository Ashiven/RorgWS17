library ieee;
use ieee.std_logic_1164.all;

entity adder is
	generic( WIDTH : integer := 32 );
	port ( a,b  : in  std_logic_vector( WIDTH-1 downto 0 );
	       sum  : out std_logic_vector( WIDTH-1 downto 0 );
	       cout : out std_logic);
end entity;

architecture behavioral of adder is

	signal coutarray: std_logic_vector(0 to WIDTH):= (others => '0');

begin

	gen: for i in 0 to WIDTH - 1 generate
	add: entity work.fulladd(behavioral)
		port map(a => a(i),	
			 b => b(i),
			 cin => coutarray(i),
		         sum => sum(i),
		         cout => coutarray(i + 1));
	end generate;

	cout <= coutarray(WIDTH);

end architecture;
