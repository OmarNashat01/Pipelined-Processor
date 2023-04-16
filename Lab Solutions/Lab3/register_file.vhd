--include

Library IEEE;
Use ieee.std_logic_1164.all;

entity register_file is 
port(   input_port:in std_logic_vector(15 downto 0);
	read_address:in std_logic_vector(1 downto 0);
	write_address:in std_logic_vector(1 downto 0);
	write_enable:in std_logic;
	Rst: in std_logic;
	Clk: in std_logic;
	output_port:out std_logic_vector(15 downto 0));
end entity;

ARCHITECTURE a_reg of register_file IS
COMPONENT nDFF IS
PORT (Clk, Rst, En: IN std_logic;
d: IN std_logic_vector(15 downto 0);
q: OUT std_logic_vector(15 downto 0)
);
END COMPONENT;
COMPONENT decoder is
port(
 En: in STD_LOGIC;
 a : in STD_LOGIC_VECTOR(1 downto 0);
 b : out STD_LOGIC_VECTOR(3 downto 0)
 );
end COMPONENT;
signal in_temp: std_logic_vector(3 downto 0);
signal ResA, ResB, ResC, ResD, Out_temp: std_logic_vector(15 downto 0);
BEGIN
dA: decoder PORT MAP (write_enable, write_address, in_temp);
pA: nDFF PORT MAP (Clk, Rst, in_temp(0), input_port, ResA);
pB: nDFF PORT MAP (Clk, Rst, in_temp(1), input_port, ResB);
pC: nDFF PORT MAP (Clk, Rst, in_temp(2), input_port, ResC);
pD: nDFF PORT MAP (Clk, Rst, in_temp(3), input_port, ResD);
with read_address select
	output_port <= ResA when "00",
		ResB when "01",
		ResC when "10",
		ResD when others;

END a_reg;