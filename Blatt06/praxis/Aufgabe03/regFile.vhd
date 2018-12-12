library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library RorgPrSimLib;
use RorgPrSimLib.all;
use RorgPrSimLib.proc_config.all;

library work;
use work.all;

entity regFile is
	generic(NUM_REGS : integer;
			LOG2_NUM_REGS : integer;
			REG_WIDTH : integer);
	port(clk : in std_logic;
		 rst : in std_logic;
		 readAddr1 : in std_logic_vector(LOG2_NUM_REGS - 1 downto 0);
		 readData1 : out std_logic_vector(REG_WIDTH - 1 downto 0);
		 readAddr2 : in std_logic_vector(LOG2_NUM_REGS - 1 downto 0);
		 readData2 : out std_logic_vector(REG_WIDTH - 1 downto 0);
		 writeEn : in std_logic;
		 writeAddr : in std_logic_vector(LOG2_NUM_REGS - 1 downto 0);
		 writeData : in std_logic_vector(REG_WIDTH - 1 downto 0);
		 reg_vect_debug : out reg_vector_type);
end regFile;

architecture structural of regFile is

	signal reg_vect : reg_vector_type;
	signal bitmsk: std_logic_vector(REG_WIDTH - 1 downto 0);
	signal empty: std_logic_vector(REG_WIDTH - 1 downto 0):= (others => '0');
	signal resetall: reg_vector_type:= (others => (others => '0'));

begin

	decoder: process(writeAddr)
	begin
		bitmsk <= empty;
		bitmsk(to_integer(unsigned(writeAddr))) <= '1';
	end process;

	writeReg: process(clk)
	begin
		if (clk'event and clk = '1') then
			if (writeEn = '1' and bitmsk(to_integer(unsigned(writeAddr))) = '1') then
				reg_vect(to_integer(unsigned(writeAddr))) <= writeData;
			elsif (rst = '1') then
					reg_vect <= resetall;
			end if;
		end if;
	end process;

	readData1 <= reg_vect(to_integer(unsigned(readAddr1)));
	readData2 <= reg_vect(to_integer(unsigned(readAddr2)));
			
	reg_vect_debug <= reg_vect;

end structural;
