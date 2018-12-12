library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ROrgPrSimLib;
use ROrgPrSimLib.proc_config.all;
use ROrgPrSimLib.flashROM;
use ROrgPrSimLib.flashRAM;

library work;
use work.all;

entity mipsCpu is
	generic(PROG_FILE_NAME : string;
			DATA_FILE_NAME : string);
	port(clk : in std_logic;
		 rst : in std_logic;
		 
		 -- instruction insertion ports
		 testMode_debug : in std_logic;
		 testInstruction_debug : in std_logic_vector(31 downto 0);
		 
		 -- ram access ports
		 ramInsertMode_debug : in std_logic;
		 ramWriteEn_debug : in std_logic;
		 ramWriteAddr_debug : in std_logic_vector(LOG2_NUM_RAM_ELEMENTS - 1 downto 0);
		 ramWriteData_debug : in std_logic_vector(RAM_ELEMENT_WIDTH - 1 downto 0);
		 ramElements_debug : out ram_elements_type;
		 
		 -- register file access port
		 registers_debug : out reg_vector_type;
		 
		 -- intermediate result ports
		 pc_next_debug : out std_logic_vector(PC_WIDTH - 1 downto 0);
		 pc7SegDigits_debug : out pc_7seg_digits_type
		 );
end mipsCpu;

architecture structural of mipsCpu is
signal instruction, shift : std_logic_vector(31 downto 0);
signal regDst, branch, memRead, memToReg, memWrite, aluSrc, regWrite, invClk, aluZero, zeroAndBranch : std_logic;
signal aluOp : std_logic_vector(1 downto 0);
signal writeAddr : std_logic_vector(4 downto 0);
signal reg1, reg2, aluResult, regData, aluIn2 : std_logic_vector(REG_WIDTH-1 downto 0);
signal aluCode : std_logic_vector(3 downto 0);
signal ramRead : std_logic_vector(RAM_ELEMENT_WIDTH-1 downto 0);
signal PC : std_logic_vector(PC_WIDTH-1 downto 0) := "00000000000000000000000000000000";
signal siExt : signed(31 downto 0);
begin

	-- Beschreibung der MIPS-CPU hier ergänzen
	CONTROL: entity work.mipsCtrl(structural)
        port map(op => instruction(31 downto 26),
            regDst => regDst,
            branch => branch,
            memRead => memRead,
            memToReg => memToReg,
            aluOp => aluOp,
            memWrite => memWrite,
            aluSrc => aluSrc,
            regWrite => regWrite);
            
    SIGN_EXTEND: entity work.signExtend(behavioral)
        generic map(INPUT_WIDTH => 16,
                    OUTPUT_WIDTH => 32)
        port map(number => signed(instruction(15 downto 0)),
                signExtNumber => siExt);
                
    LEFT_SHIFT: entity work.leftShifter(behavioral)
        generic map(WIDTH => 32,
                    SHIFT_AMOUNT => 2)
        port map(number => std_logic_vector(siExt),
                shiftedNumber => shift);
                
    REGISTRY: entity work.regFile(structural)
        generic map(NUM_REGS => NUM_REGS,
                    LOG2_NUM_REGS => LOG2_NUM_REGS,
                    REG_WIDTH => REG_WIDTH)
        port map(clk => clk,
                rst => rst,
                readAddr1 => instruction(25 downto 21),
                readData1 => reg1,
                readAddr2 => instruction(20 downto 16),
                readData2 => reg2,
                writeEn => regWrite,
                writeAddr => writeAddr,
                writeData => regData,
                reg_vect_debug => registers_debug);
                
	ALU_CTRL: entity work.aluCtrl(behavioral)
        port map(aluOp => aluOp,
                f => instruction(5 downto 0),
                operation => aluCode);
                
    ALU: entity work.csAlu(behavioral)
        generic map(WIDTH => REG_WIDTH)
        port map(ctrl => aluCode,
                a => reg1,
                b => aluIn2,
                result => aluResult,
                overflow => open,
                zero => aluZero);
                
    zeroAndBranch <= aluZero and branch;
    pcAndMux: process(PC, shift, zeroAndBranch, clk)
    begin
        if(clk'EVENT and clk = '0') then
            case zeroAndBranch is
                when '0' => PC <= std_logic_vector(unsigned(PC)+4);
                when '1' => PC <= std_logic_vector(unsigned(PC)+unsigned(shift));
                when others => PC <= PC;
            end case;
        end if;
        case regDst is
            when '1' => writeAddr <= instruction(15 downto 11);
            when '0' => writeAddr <= instruction(20 downto 16);
            when others => null;
        end case;
        case memToReg is
            when '1' => regData <= ramRead;
            when '0' => regData <= aluResult;
            when others => null;
        end case;
        case aluSrc is
            when '1' => aluIn2 <= std_logic_vector(siExt);
            when '0' => aluIn2 <= reg2;
            when others => null;
        end case;
    end process;
	-- Instruction Memory
	INSTR_ROM: entity ROrgPrSimLib.flashROM(behavioral)
		generic map(NUM_ELEMENTS => NUM_ROM_ELEMENTS,
		            LOG2_NUM_ELEMENTS => LOG2_NUM_ROM_ELEMENTS,
					ELEMENT_WIDTH => 32,
					INIT_FILE_NAME => PROG_FILE_NAME)
		port map(address => PC(11 downto 2),
				 readData => instruction);
	
	-- Data Memory
	invClk <= not clk;
	DATA_RAM: entity ROrgPrSimLib.flashRAM(behavioral)
		generic map(NUM_ELEMENTS => NUM_RAM_ELEMENTS,
					LOG2_NUM_ELEMENTS => LOG2_NUM_RAM_ELEMENTS,
					ELEMENT_WIDTH => RAM_ELEMENT_WIDTH,
					INIT_FILE_NAME => DATA_FILE_NAME)
		port map(clk => invClk,
				 address => aluResult(11 downto 2),
				 writeEn => memWrite,
				 writeData => reg2,
				 readEn => memRead,
				 readData => ramRead,
				 ramElements_debug => ramElements_debug);

end structural;

