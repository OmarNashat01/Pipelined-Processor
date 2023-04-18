library IEEE;
use IEEE.std_logic_1164.all;


entity tb_partB is
end entity;


Architecture testingPartB of tb_partB is

component partB is 
GENERIC (n : INTEGER := 16);
	PORT (
		A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Cout : OUT STD_LOGIC);
end component;

Signal testA: std_logic_vector(15 downto 0);
Signal testB: std_logic_vector(15 downto 0);
Signal testF: std_logic_vector(15 downto 0);
Signal testS: std_logic_vector(1 downto 0);
Signal testCout: std_logic;

Begin

  U1: partB generic map (16) port map (testA, testB, testF, testS, testCout);
process
begin

-- test case part B:
-- test case 1 (or):
testA <= "1100000000111000";
testB <= "0010110000000111";
testS <= "10";

wait for 10 ns;

assert (testF = "1110110000111111" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 2 (and):
testA <= "1100000000111000";
testB <= "0000001011000000";
testS <= "01";

wait for 10 ns;

assert (testF = "0000000000000000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

    
-- test case 3 (not):
testA <= "1100000000000111";
testS <= "11";

wait for 10 ns;

assert (testF = "0011111111111000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;


-- test case 3 (not):
testA <= "1100000000000111";
testS <= "00";

wait for 10 ns;

assert (testF = "0011111111111000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;
wait;


end process;


end testingPartB;

