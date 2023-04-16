--include

Library IEEE;
Use ieee.std_logic_1164.all;

entity partD is 
generic (n: integer := 10);
port( A,B:in std_logic_vector(n-1 downto 0);
	F:out std_logic_vector(n-1 downto 0);
	S:in std_logic_vector(1 downto 0);
	Cin:in std_logic;
	Cout:out std_logic);
end entity;

Architecture impPartD of partD is
begin
F<= '0' & A(n-1 downto 1) when S= "00" 
else A(0)  & A(n-1 downto 1) when S="01"
else  Cin  & A(n-1 downto 1) when S="10"
else A(9) & A(n-1 downto 1);

Cout<= A(0) when S= "00" 
else A(0) when S="01"
else A(0) when S="10"
else '0';
end impPartD;
