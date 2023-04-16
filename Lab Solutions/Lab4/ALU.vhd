--include

Library IEEE;
Use ieee.std_logic_1164.all;

entity ALU is 
port( A,B:in std_logic_vector(15 downto 0);
	F:out std_logic_vector(15 downto 0);
	S:in std_logic_vector(3 downto 0);
	Cin:in std_logic);
end entity;

Architecture struct of ALU is
Component partA is 
port( A,B:in std_logic_vector(15 downto 0);
	F:out std_logic_vector(15 downto 0);
	S:in std_logic_vector(1 downto 0);
	Cin:in std_logic);
end Component;
Component partD is
port ( A,B:in std_logic_vector(15 downto 0);
	F:out std_logic_vector(15 downto 0);
	S:in std_logic_vector(1 downto 0);
	Cin:in std_logic);
End Component;
signal F_temp0, F_temp1, F_temp2, F_temp3: std_logic_vector(15 downto 0);
begin
pA: partA PORT MAP (A, B, F_temp0, S(1 downto 0), Cin);
pD: partD PORT MAP (A, B, F_temp3, S(1 downto 0), Cin);

F <= F_temp0 when S(3 downto 2) = "00"
else F_temp1 when S(3 downto 2) = "01"
else F_temp2 when S(3 downto 2) = "10"
else F_temp3;
end struct;





