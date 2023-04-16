LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY ram IS
PORT (Clk : IN std_logic;
En : IN std_logic;
Rst: IN std_logic;
read_address : IN std_logic_vector(1 DOWNTO 0);
write_address : IN std_logic_vector(1 DOWNTO 0);
datain : IN std_logic_vector(15 DOWNTO 0);
dataout : OUT std_logic_vector(15 DOWNTO 0) );
END ENTITY ram;

ARCHITECTURE sync_ram_a OF ram IS
TYPE ram_type IS ARRAY(0 TO 3) of std_logic_vector(15 DOWNTO 0);
SIGNAL ram : ram_type ;
BEGIN
PROCESS(Clk, Rst) IS
BEGIN
IF Rst = '1' THEN 
	ram(0) <= (OTHERS=>'0');
	ram(1) <= (OTHERS=>'0');
	ram(2) <= (OTHERS=>'0');
	ram(3) <= (OTHERS=>'0');
ELSIF rising_edge(Clk) THEN
    IF En = '1' THEN
        ram(to_integer(unsigned((write_address)))) <= datain;
    END IF;
END IF;
END PROCESS;
dataout <= ram(to_integer(unsigned((read_address))));
END sync_ram_a;