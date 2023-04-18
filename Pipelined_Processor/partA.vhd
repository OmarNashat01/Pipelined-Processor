LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY partA IS
    GENERIC (n : INTEGER := 16);
    PORT (
        A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Cin : IN STD_LOGIC;
        Cout : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE impPartA OF partA IS
    COMPONENT nbit_adder IS
        GENERIC (n : INTEGER := 16);
        PORT (
            A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            Cin : IN STD_LOGIC;
            Cout : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL ResCout : STD_LOGIC;
    SIGNAL ResB, Sum : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
BEGIN
    WITH S SELECT
        ResB <= (OTHERS => '0') WHEN "00",
        B WHEN "01",
        NOT B WHEN "10",
        (OTHERS => '1') WHEN OTHERS;

    Z1 : nbit_adder GENERIC MAP(n) PORT MAP(A, ResB, Sum, Cin, ResCout);

    F <= B WHEN Cin = '1' AND S = "11"
        ELSE
        Sum;

    Cout <= '0' WHEN Cin = '1' AND S = "11"
        ELSE
        ResCout;

END impPartA;