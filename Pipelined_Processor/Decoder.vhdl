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
BEGIN

    WALU_Type2 <= "01" WHEN opCode(2 DOWNTO 0) = "111" ELSE
        "00";

        -- Type 0
        IF opCode(4 DOWNTO 3) = "00" THEN
            signals <= opCode(5) & "00000000011";

            -- Type 1
        ELSIF opCode(4 DOWNTO 3) = "01" THEN

            signals <= opCode(5) & -- LNG
                "0" & "0" & -- PCJMP & DECSP
                (opCode(1) AND opCode(0)) & -- INCSP
                "00" & "0" & -- WALU & IOW
                opCode(2) & -- IOR
                "0" & "0" & -- EX & MEMW
                opCode(1) & -- MEMR
                "1"; -- WB   

            -- Type 2
        ELSIF opCode(4 DOWNTO 3) = "10" THEN

            signals <= opCode(5) & -- LNG
                opCode(0) & -- PCJMP
                (NOT opCode(2) AND opCode(1)) & -- DECSP
                opCode(2) & -- INCSP
                WALU_Type2 & -- WALU
                "0" & "0" & "0" & -- IOW & IOR & EX
                (NOT opCode(2)) & -- MEMW
                opCode(2) & -- MEMR
                "0"; -- WB

            -- Type 3
        ELSE
            WITH opCode(2 DOWNTO 0) SELECT
            signals <= 
                opCode(5) & "00000000000" WHEN "000", -- NOP
                opCode(5) & "00000000000" WHEN "001", -- JZ
                opCode(5) & "00000000000" WHEN "010", -- JC
                opCode(5) & "00011000000" WHEN "100", -- SETC
                opCode(5) & "00010000000" WHEN "101", -- CLRC
                opCode(5) & "00000100000" WHEN "110", -- OUT
                opCode(5) & "10000000000" WHEN "111"; -- RETS
        END IF;
END myDecoder;