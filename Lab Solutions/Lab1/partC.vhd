--include

Library IEEE;
Use ieee.std_logic_1164.all;

entity partC is 
generic (n: integer := 10);
port( A,B:in std_logic_vector(n-1 downto 0);
	F:out std_logic_vector(n-1 downto 0);
	S:in std_logic_vector(1 downto 0);
	Cin:in std_logic;
	Cout:out std_logic);
end entity;

Architecture impPartC of partC is
begin
F<=  A(n-2 downto 0) & '0' when S= "00" 
else A(n-2 downto 0) & A(n-1) when S="01"
else  A(n-2 downto 0) & Cin when S="10"
else (others => '0');

Cout<= A(n-1) when S= "00" 
else A(n-1) when S="01"
else A(n-1) when S="10"
else '0';
end impPartC;

