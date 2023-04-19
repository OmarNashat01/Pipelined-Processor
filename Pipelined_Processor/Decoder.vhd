LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder IS
    PORT (
        enable : IN STD_LOGIC;

        -- (LNG, type, 3 bit differentiator)
        opCode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);

        -- (LNG, PCJMP, DECSP, INCSP, WALU, IOW, IOR, EX, MEMW, MEMR, WB)
        signals : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END Decoder;

ARCHITECTURE myDecoder OF Decoder IS
    SIGNAL WALU_Type2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL Type0_Signals : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL Type1_Signals : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL Type2_Signals : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL Type3_Signals : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL OutSignals : STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN

    WALU_Type2 <= "01" WHEN opCode(2 DOWNTO 0) = "111" ELSE
        "00";

    Type0_Signals <= opCode(5) & "00000001001";

    Type1_Signals <=
        opCode(5) & -- LNG
        "0" & "0" & -- PCJMP & DECSP
        (opCode(1) AND opCode(0)) & -- INCSP
        "00" & "0" & -- WALU & IOW
        opCode(2) & -- IOR
        "0" & "0" & -- EX & MEMW
        opCode(1) & -- MEMR
        "1"; -- WB   

    Type2_Signals <=
        opCode(5) & -- LNG
        opCode(0) & -- PCJMP
        (NOT opCode(2) AND opCode(1)) & -- DECSP
        opCode(2) & -- INCSP
        WALU_Type2 & -- WALU
        "0" & "0" & "0" & -- IOW & IOR & EX
        (NOT opCode(2)) & -- MEMW
        opCode(2) & -- MEMR
        "0"; -- WB

    WITH opCode(2 DOWNTO 0) SELECT
    Type3_Signals <=
        opCode(5) & "00011000000" WHEN "100", -- SETC
        opCode(5) & "00010000000" WHEN "101", -- CLRC
        opCode(5) & "00000100000" WHEN "110", -- OUT
        opCode(5) & "10000000000" WHEN "111", -- RETS

        opCode(5) & "00000000000" WHEN OTHERS; -- JC, JZ, NOP
    WITH opCode(4 DOWNTO 3) SELECT
    OutSignals <=
        Type0_Signals WHEN "00",
        Type1_Signals WHEN "01",
        Type2_Signals WHEN "10",
        Type3_Signals WHEN OTHERS;

    WITH enable SELECT
        signals <=
        "000000000000" WHEN '0', -- when enable is 0, all signals are 0 (NOP)
        OutSignals WHEN OTHERS;
END myDecoder;