LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY ALU IS
    GENERIC (n : INTEGER := 16);
    PORT (
        src1, src2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        opCode : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        EX : IN STD_LOGIC;
        WALU : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        aluOut : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE struct OF ALU IS
    COMPONENT partA IS
        GENERIC (n : INTEGER := 16);
        PORT (
            A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            Cout : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT partB IS
        GENERIC (n : INTEGER := 16);
        PORT (
            A, B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            Cout : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL Cout_temp0, Cout_temp1 : STD_LOGIC;
    SIGNAL F_temp0, F_temp1 : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);

    SIGNAL ALUOut_temp : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL flagRegister : STD_LOGIC_VECTOR(2 DOWNTO 0); -- (C, N, Z)
    SIGNAL flagRegister_temp : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    pA : partA PORT MAP(src1, src2, F_temp0, opCode(1 DOWNTO 0), Cout_temp0);
    pB : partB PORT MAP(src1, src2, F_temp1, opCode(1 DOWNTO 0), Cout_temp1);

    WITH EX SELECT
    aluOut <=
        ALUOut_temp WHEN '1', -- so i can read output and set flags
        src2 WHEN OTHERS;

    WITH opCode(2) SELECT
    ALUOut_temp <=
        F_temp0 WHEN '0',
        F_temp1 WHEN OTHERS;

    -- Flags
    -- C
    WITH opCode(2) SELECT
    flagRegister_temp(2) <=
    Cout_temp0 WHEN '0',
    flagRegister(2) WHEN OTHERS;

    -- N
    WITH ALUOut_temp(n - 1) SELECT
    flagRegister_temp(1) <=
    '1' WHEN '1',
    '0' WHEN OTHERS;

    -- Z
    WITH ALUOut_temp SELECT
        flagRegister_temp(0) <=
        '1' WHEN x"0000",
        '0' WHEN OTHERS;
    WITH EX SELECT
        flagRegister <=
        flagRegister_temp WHEN '1',
        flagRegister WHEN OTHERS;

END struct;