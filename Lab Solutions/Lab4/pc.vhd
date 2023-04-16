LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY pc IS
PORT (Clk : IN std_logic;
En: IN std_logic;
Rst: IN std_logic;
Counter : OUT std_logic_vector(9 DOWNTO 0));
END ENTITY pc;

ARCHITECTURE imp_pc OF pc IS
BEGIN
PROCESS(Clk, Rst) IS
variable C: std_logic_vector(9 downto 0):=(others=>'0');
BEGIN
IF Rst = '1' THEN 
	C:=(OTHERS=>'0');
	Counter <= C;
ELSIF rising_edge(Clk) THEN
    IF En = '1' THEN
        C:=std_logic_vector(to_unsigned(to_integer(unsigned(C))+1,10));
	Counter <= C;
    END IF;
END IF;

END PROCESS;
END imp_pc;
