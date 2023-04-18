--include

LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY nbit_adder IS
	GENERIC (n : INTEGER := 16);
	PORT (
		A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		Cin : IN STD_LOGIC;
		Cout : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE imp_nbit_adder OF nbit_adder IS
	COMPONENT my_nadder IS
		GENERIC (m : INTEGER := 2);
		PORT (
			a, b : IN STD_LOGIC_VECTOR(m - 1 DOWNTO 0);
			cin : IN STD_LOGIC;
			s : OUT STD_LOGIC_VECTOR(m - 1 DOWNTO 0);
			cout : OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT select_adder IS
		GENERIC (m : INTEGER := 2);
		PORT (
			a, b : IN STD_LOGIC_VECTOR(m - 1 DOWNTO 0);
			cin : IN STD_LOGIC;
			s : OUT STD_LOGIC_VECTOR(m - 1 DOWNTO 0);
			cout : OUT STD_LOGIC);
	END COMPONENT;
	SIGNAL C : STD_LOGIC_VECTOR(n/2 DOWNTO 0);
BEGIN
	C(0) <= Cin;
	Cout <= C(n/2);
	U1 : my_nadder GENERIC MAP(2) PORT MAP(A(1 DOWNTO 0), B(1 DOWNTO 0), C(0), F(1 DOWNTO 0), C(1));
	loop1 : FOR i IN 1 TO (n/2) - 1 GENERATE
		UX : select_adder GENERIC MAP(2) PORT MAP(A((2 * i + 1) DOWNTO 2 * i), B((2 * i + 1) DOWNTO 2 * i), C(i), F((2 * i + 1) DOWNTO 2 * i), C(i + 1));
	END GENERATE;
END imp_nbit_adder;