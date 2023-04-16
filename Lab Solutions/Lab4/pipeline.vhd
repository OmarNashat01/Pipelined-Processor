Library IEEE;
Use ieee.std_logic_1164.all;

entity pipeline is 
PORT (Clk : IN std_logic;
En: IN std_logic;
Rst: IN std_logic);
end entity;

ARCHITECTURE imp_pipeline of pipeline IS

COMPONENT pc IS
PORT (Clk : IN std_logic;
En: IN std_logic;
Rst: IN std_logic;
Counter : OUT std_logic_vector(9 DOWNTO 0));
END COMPONENT pc;

COMPONENT instruction_cache IS
PORT
(read_address : IN std_logic_vector(9 DOWNTO 0);
dataout : OUT std_logic_vector(15 DOWNTO 0) );
END COMPONENT;

COMPONENT controller IS
PORT(   op_code:in std_logic_vector(2 downto 0);
	alu_selector:out std_logic_vector(4 downto 0);
	write_enable:out std_logic);
END COMPONENT;

COMPONENT nDFF IS
GENERIC (n: integer := 16);
PORT (Clk, Rst, En: IN std_logic;
d: IN std_logic_vector(n-1 downto 0);
q: OUT std_logic_vector(n-1 downto 0));
END COMPONENT;

COMPONENT ALU is 
port( A,B:in std_logic_vector(15 downto 0);
	F:out std_logic_vector(15 downto 0);
	S:in std_logic_vector(3 downto 0);
	Cin:in std_logic);
END COMPONENT;

COMPONENT register_file_mem is 
port(   input_port:in std_logic_vector(15 downto 0);
	read_address:in std_logic_vector(1 downto 0);
	write_address:in std_logic_vector(1 downto 0);
	write_enable:in std_logic;
	Clk: in std_logic;
	output_port:out std_logic_vector(15 downto 0));
END COMPONENT;

COMPONENT DecodeExecuteRegister is 
port (  Clk, Rst, En: IN std_logic;
	Controller_WriteEnable_ALUSelector_In:in std_logic_vector(5 downto 0);
	RegisterFile_In:in std_logic_vector(15 downto 0);
	FetchDecode_WriteAddress_In:in std_logic_vector(1 downto 0);
	Controller_WriteEnable_ALUSelector_Out:out std_logic_vector(5 downto 0);
	RegisterFile_Out:out std_logic_vector(15 downto 0);
	FetchDecode_WriteAddress_Out:out std_logic_vector(1 downto 0));
END COMPONENT;


Signal Cache_Address: std_logic_vector(9 downto 0);
Signal Instruction: std_logic_vector(15 downto 0);
Signal alu_selector: std_logic_vector(4 downto 0);
Signal write_enable: std_logic;
Signal Fetch_Decode_Out: std_logic_vector(15 downto 0);
Signal Temp0: std_logic_vector(15 downto 0);
Signal srcData: std_logic_vector(15 downto 0);
Signal ALUinput: std_logic_vector(15 downto 0);
Signal ALUoutput: std_logic_vector(15 downto 0);
Signal Write_Back_Out: std_logic_vector(18 downto 0);
Signal DecodeExecute_ALU: std_logic_vector(5 downto 0);
Signal DecodeExecute_WriteAddress: std_logic_vector(1 downto 0);

BEGIN

PC1: pc PORT MAP (Clk, En, Rst, Cache_Address);
IC1: instruction_cache PORT MAP (Cache_Address, Instruction); 
FD1: nDFF GENERIC MAP (16) PORT MAP (Clk, Rst, En, Instruction, Fetch_Decode_Out);
C1: controller PORT MAP (Fetch_Decode_Out(15 downto 13), alu_selector, write_enable);
RF1: register_file_mem PORT MAP (Write_Back_Out(17 downto 2), Fetch_Decode_Out(11 downto 10), Write_Back_Out(1 downto 0), Write_Back_Out(18), Clk, srcData);
DE1: DecodeExecuteRegister PORT MAP (Clk, Rst, En, write_enable & alu_selector, srcData, Fetch_Decode_Out(11 downto 10), DecodeExecute_ALU, ALUinput, DecodeExecute_WriteAddress);
ALU1: ALU PORT MAP (ALUinput, Temp0, ALUoutput, DecodeExecute_ALU(4 downto 1), DecodeExecute_ALU(0));
WB1: nDFF GENERIC MAP (19) PORT MAP (Clk, Rst, En, DecodeExecute_ALU(5) & ALUoutput & DecodeExecute_WriteAddress, Write_Back_Out);

END imp_pipeline;
