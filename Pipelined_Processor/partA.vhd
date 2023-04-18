LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY partA IS
    GENERIC (n : INTEGER := 16);
    PORT (
        A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Cout : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE impPartA OF partA IS
    COMPONENT nbit_adder IS
        GENERIC (n : INTEGER := 16);
        PORT (
            A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            Cin: IN STD_LOGIC;
            Cout : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL ResB : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL Cin, ResCout: STD_LOGIC;
BEGIN
    WITH S SELECT
        ResB <= (OTHERS => '0') WHEN "00",
        B WHEN "01",
        NOT B WHEN "10",
        (OTHERS => '1') WHEN OTHERS;

    WITH S SELECT
        Cin <= '1' WHEN "00",
        '0' WHEN "01",
        '1' WHEN "10",
        '0' WHEN OTHERS;     

    Z1 : nbit_adder PORT MAP(A, ResB, F, Cin, ResCout);

	Cout <= ResCout XOR S(1);

END impPartA;