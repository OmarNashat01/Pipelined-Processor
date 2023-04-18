library IEEE;
use IEEE.std_logic_1164.all;


entity tb_partA is
end entity;


Architecture testingALU of tb_partA is

COMPONENT partA IS
    GENERIC (n : INTEGER := 16);
    PORT (
        A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Cout : OUT STD_LOGIC);
END COMPONENT;

Signal testA: std_logic_vector(15 downto 0);
Signal testB: std_logic_vector(15 downto 0);
Signal testF: std_logic_vector(15 downto 0);
Signal testS: std_logic_vector(1 downto 0);
Signal testCout: std_logic;

Begin

  U1: partA port map (testA, testB, testF, testS, testCout);
process
begin

-- test case part A:
-- test case 1:
testA <= x"0004";
testB <= x"0005";
testS <= "00";

wait for 10 ns;

assert (testF = x"0005" and testCout = '0')
	report "Failed Case 1: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 2:
testS <= "01";

wait for 10 ns;

assert (testF = x"0009" and testCout = '0')
	report "Failed Case 2: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 3:
testS <= "10";

wait for 10 ns;

assert (testF = x"FFFF" and testCout = '1')
	report "Failed Case 3: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 4:
testS <= "11";

wait for 10 ns;

assert (testF = x"0003" and testCout = '0')
	report "Failed Case 4: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

wait;


end process;


end testingALU;

