LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY my_nadder IS
    generic (m: integer := 2);
	PORT (a,b : IN  std_logic_vector(m-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(m-1 downto 0);
           cout : OUT std_logic );
END my_nadder;

ARCHITECTURE a_my_adder OF my_nadder IS
component my_adder IS
	PORT (a,b,cin : IN  std_logic;
		  s, cout : OUT std_logic );
END component;

    signal temp : std_logic_vector(m downto 0);
	BEGIN
		
		temp(0) <= cin;
        loop1: for i in 0 to m-1 generate
            fx:my_adder port map(a(i),b(i),temp(i),s(i),temp(i+1));
        end generate;
		cout <= temp(m);
END a_my_adder;