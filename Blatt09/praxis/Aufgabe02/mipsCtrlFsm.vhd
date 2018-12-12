library ieee;
use ieee.std_logic_1164.all;

library ROrgPrSimLib;
use ROrgPrSimLib.proc_config.mips_ctrl_state_type;
use ROrgPrSimLib.mipsISA.all;

entity mipsCtrlFsm is
port(clk : in std_logic;
	 rst : in std_logic;
	 op : in std_logic_vector(5 downto 0);
	 regDst : out std_logic;
	 memRead : out std_logic;
	 memToReg : out std_logic;
	 aluOp : out std_logic_vector(1 downto 0);
	 memWrite : out std_logic;
	 regWrite : out std_logic;
	 aluSrcA : out std_logic;
	 aluSrcB : out std_logic_vector(1 downto 0);
	 pcSrc : out std_logic_vector(1 downto 0);
	 irWrite : out std_logic;
	 IorD : out std_logic;
	 pcWrite : out std_logic;
	 pcWriteCond : out std_logic;
	 
	 -- debug port
	 mipsCtrlState_debug : out mips_ctrl_state_type);
end mipsCtrlFsm;

architecture behavioral of mipsCtrlFsm is
	
	signal state_reg : mips_ctrl_state_type;
	
begin

	-- Beschreibung der MIPS Control FSM hier einfügen
	
	mipsCtrlState_debug <= state_reg;
	
end behavioral;
