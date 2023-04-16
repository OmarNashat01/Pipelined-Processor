library IEEE;
use IEEE.std_logic_1164.all;


entity tb_ALU is
end entity;


Architecture testingALU of tb_ALU is

component ALU is 
generic (n: integer := 10);
port( A,B:in std_logic_vector(n-1 downto 0);
	F:out std_logic_vector(n-1 downto 0);
	S:in std_logic_vector(3 downto 0);
	Cin:in std_logic;
	Cout:out std_logic);
end component;

Signal testA: std_logic_vector(9 downto 0);
Signal testB: std_logic_vector(9 downto 0);
Signal testF: std_logic_vector(9 downto 0);
Signal testS: std_logic_vector(3 downto 0);
Signal testCin: std_logic;
Signal testCout: std_logic;

Begin

  U1: ALU generic map (10) port map (testA, testB, testF, testS, testCin, testCout);
process
begin

-- test case part A:
-- test case 1:
testA <= "1100001111";
testCin <= '0';
testS <= "0000";

wait for 10 ns;

assert (testF = "1100001111" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 2:
testA <= "1100001111";
testB <= "0000000001";
testS <= "0001";
testCin <= '0';

wait for 10 ns;

assert (testF = "1100010000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 3:
testA <= "1111111111";
testB <= "0000000001";
testS <= "0010";
testCin <= '0';

wait for 10 ns;

assert (testF = "1111111101" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 4:
testA <= "1111111111";
testS <= "0011";
testCin <= '0';

wait for 10 ns;

assert (testF = "1111111110" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 5:
testA <= "0000001110";
testS <= "0000";
testCin <= '1';

wait for 10 ns;

assert (testF = "0000001111" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 6:
testA <= "1111111111";
testB <= "0000000001";
testS <= "0001";
testCin <= '1';

wait for 10 ns;

assert (testF = "0000000001" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 7:
testA <= "0000000000";
testB <= "0000000001";
testS <= "0010";
testCin <= '1';

wait for 10 ns;

assert (testF = "1111111111" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 8:
testA <= "0000001111";
testB <= "0000000001";
testS <= "0011";
testCin <= '1';

wait for 10 ns;

assert (testF = "0000000001" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case part B:
-- test case 1:
testA <= "1100000000";
testB <= "0010110000";
testS <= "0100";

wait for 10 ns;

assert (testF = "1110110000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 2:
testA <= "1100000000";
testB <= "0000001011";
testS <= "0101";

wait for 10 ns;

assert (testF = "0000000000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 3:
testA <= "1100000000";
testB <= "0010110000";
testS <= "0110";

wait for 10 ns;

assert (testF = "0001001111" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA) & ", B: " & to_hstring(testB)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 4:
testA <= "1100000000";
testS <= "0111";

wait for 10 ns;

assert (testF = "0011111111" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case part C:
-- test case 1:
testA <= "1000001010";
testS <= "1000";

wait for 10 ns;

assert (testF = "0000010100" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 2:
testA <= "1100001100";
testS <= "1001";

wait for 10 ns;

assert (testF = "1000011001" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 3:
testA <= "1000001010";
testS <= "1010";
testCin <= '0';

wait for 10 ns;

assert (testF = "0000010100" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 4:
testA <= "1000001010";
testS <= "1011";

wait for 10 ns;

assert (testF = "0000000000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 5:
testA <= "0000001010";
testS <= "1000";

wait for 10 ns;

assert (testF = "0000010100" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 6:
testA <= "0000001100";
testS <= "1001";

wait for 10 ns;

assert (testF = "0000011000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 7:
testA <= "1000001010";
testS <= "1010";
testCin <= '1';

wait for 10 ns;

assert (testF = "0000010101" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case part D:
-- test case 1:
testA <= "0000001111";
testS <= "1100";

wait for 10 ns;

assert (testF = "0000000111" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 2:
testA <= "0000001111";
testS <= "1101";

wait for 10 ns;

assert (testF = "1000000111" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 3:
testA <= "0000001111";
testS <= "1110";
testCin <= '0';

wait for 10 ns;

assert (testF = "0000000111" and testCout = '1')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 4:
testA <= "0011110000";
testS <= "1110";
testCin <= '1';

wait for 10 ns;

assert (testF = "1001111000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

-- test case 5:
testA <= "1100000000";
testS <= "1111";

wait for 10 ns;

assert (testF = "1110000000" and testCout = '0')
	report "Failed Case: A: " & to_hstring(testA)
		& ", S: " & to_hstring(testS)  
		& ", F: " & to_hstring(testF) 
		& ", Cout: " &  std_logic'image(testCout) 
	severity error;

wait;


end process;


end testingALU;

