--include

Library IEEE;
Use ieee.std_logic_1164.all;

entity partA is 
port (  A,B:in std_logic_vector(15 downto 0);
	F:out std_logic_vector(15 downto 0);
	S:in std_logic_vector(1 downto 0);
	Cin:in std_logic);
end entity;

Architecture impPartA of partA is
Component nbit_adder is 
port (  A,B:in std_logic_vector(15 downto 0);
	F:out std_logic_vector(15 downto 0);
	Cin:in std_logic;
	Cout:out std_logic);
End Component;
signal ResCout: std_logic;
signal ResB, Sum: std_logic_vector(15 downto 0);
begin
with S select
	ResB <= (others => '0') when "00",
		B when "01",
		not B when "10",
		(others => '1') when others;

Z1: nbit_adder PORT MAP (A, ResB, Sum, Cin, ResCout);

F <= B  when Cin = '1' AND S = "11"
	else Sum;


end impPartA;


