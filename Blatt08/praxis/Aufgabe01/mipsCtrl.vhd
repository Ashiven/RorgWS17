library ieee;
use ieee.std_logic_1164.all;

entity mipsCtrl is
	port(op : in std_logic_vector(5 downto 0);
		 regDst : out std_logic;
		 branch : out std_logic;
		 memRead : out std_logic;
		 memToReg : out std_logic;
		 aluOp : out std_logic_vector(1 downto 0);
		 memWrite : out std_logic;
		 aluSrc : out std_logic;
		 regWrite : out std_logic);
end mipsCtrl;

architecture structural of mipsCtrl is
signal result : std_logic_vector(3 downto 0);
begin

    result(0) <= (not op(0)) and (not op(1)) and (not op(2)) and (not op(3)) and (not op(4)) and (not op(5));
    result(1) <= op(0) and op(1) and (not op(2)) and (not op(3)) and (not op(4)) and op(5);
    result(2) <= op(0) and op(1) and (not op(2)) and op(3) and (not op(4)) and op(5);
    result(3) <= (not op(0)) and (not op(1)) and op(2) and (not op(3)) and (not op(4)) and (not op(5));
    regDst <= result(0);
    aluSrc <= result(1) or result(2);
    memToReg <= result(1);
    regWrite <= result(0) or result(1);
    memRead <= result(1);
    memWrite<= result(2);
    branch <= result(3);
    aluOp(1) <= result(0);
    aluOp(0) <= result(3);

	
end structural;
