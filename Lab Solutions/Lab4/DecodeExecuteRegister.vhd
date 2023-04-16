--include

Library IEEE;
Use ieee.std_logic_1164.all;

entity DecodeExecuteRegister is 
port (  Clk, Rst, En: IN std_logic;
	Controller_WriteEnable_ALUSelector_In:in std_logic_vector(5 downto 0);
	RegisterFile_In:in std_logic_vector(15 downto 0);
	FetchDecode_WriteAddress_In:in std_logic_vector(1 downto 0);
	Controller_WriteEnable_ALUSelector_Out:out std_logic_vector(5 downto 0);
	RegisterFile_Out:out std_logic_vector(15 downto 0);
	FetchDecode_WriteAddress_Out:out std_logic_vector(1 downto 0));
end entity;

Architecture impDecodeExecuteRegister of DecodeExecuteRegister is
COMPONENT nDFF IS
GENERIC (n: integer := 16);
PORT (Clk, Rst, En: IN std_logic;
d: IN std_logic_vector(n-1 downto 0);
q: OUT std_logic_vector(n-1 downto 0));
END COMPONENT;

BEGIN
D1: nDFF GENERIC MAP (6) PORT MAP (Clk, Rst, En, Controller_WriteEnable_ALUSelector_In, Controller_WriteEnable_ALUSelector_Out);
D3: nDFF GENERIC MAP (16) PORT MAP (Clk, Rst, En, RegisterFile_In, RegisterFile_Out);
D4: nDFF GENERIC MAP (2) PORT MAP (Clk, Rst, En, FetchDecode_WriteAddress_In, FetchDecode_WriteAddress_Out);

END impDecodeExecuteRegister;


