--include

Library IEEE;
Use ieee.std_logic_1164.all;

ENTITY nDFF IS
PORT (Clk, Rst, En: IN std_logic;
d: IN std_logic_vector(15 downto 0);
q: OUT std_logic_vector(15 downto 0));
END nDFF;

ARCHITECTURE a_nDFF OF nDFF IS
BEGIN
PROCESS(Clk, Rst)
BEGIN
	IF Rst = '1' THEN 
		q<= (OTHERS=>'0');
	ELSIF rising_edge(Clk) THEN
		IF En = '1' THEN 
				q<=d;
		END IF;
END IF;
END PROCESS;
END a_nDFF;
