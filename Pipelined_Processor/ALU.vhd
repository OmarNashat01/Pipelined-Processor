LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY ALU IS
    GENERIC (n : INTEGER := 16);
    PORT (
        src1, src2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        opCode : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        cIn : IN STD_LOGIC;
        aluOut : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        cOut : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE struct OF ALU IS
    COMPONENT partA IS
        GENERIC (n : INTEGER := 16);
        PORT (
            A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            Cin : IN STD_LOGIC;
            Cout : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT partB IS
        GENERIC (n : INTEGER := 16);
        PORT (
            A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            Cin : IN STD_LOGIC;
            Cout : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL Cout_temp0, Cout_temp1, Cout_temp2, Cout_temp3 : STD_LOGIC;
    SIGNAL F_temp0, F_temp1, F_temp2, F_temp3 : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
BEGIN
    pA : partA PORT MAP(src1, src2, F_temp0, opCode(1 DOWNTO 0), cIn, Cout_temp0);
    pB : partB PORT MAP(src1, src2, F_temp1, opCode(1 DOWNTO 0), cIn, Cout_temp1);

    WITH opCode(2) SELECT
    aluOut <=
        F_temp0 WHEN '0',
        F_temp1 WHEN OTHERS;

    WITH opCode(2) SELECT
    cOut <=
        Cout_temp0 WHEN '0',
        Cout_temp1 WHEN OTHERS;

END struct;