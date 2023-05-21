LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY HDU IS
    GENERIC (N : INTEGER := 16);
    PORT (
        clock : IN STD_LOGIC;
        -- Load Use Case
        loadUseHazard : IN STD_LOGIC;


        -- Handling the PC
        PCEnable, PCReset : OUT STD_LOGIC;

        -- For stalling or flushing the pipeline
        FetchBufferEnable, FetchBufferReset : OUT STD_LOGIC;
        DecodeBufferEnable, DecodeBufferReset : OUT STD_LOGIC;
        ExecuteBufferEnable, ExecuteBufferReset : OUT STD_LOGIC;
        Memory1BufferEnable, Memory1BufferReset : OUT STD_LOGIC;
        Memory2BufferEnable, Memory2BufferReset : OUT STD_LOGIC
    );
END ENTITY HDU;

ARCHITECTURE myHDU OF HDU IS
BEGIN

    PROCESS (loadUseHazard, clock)
    BEGIN
    IF falling_edge(clock) THEN
        IF loadUseHazard = '1' THEN
            PCEnable <= '0';
            PCReset <= '0';

            FetchBufferEnable <= '0';
            FetchBufferReset <= '0';

            DecodeBufferEnable <= '0';
            DecodeBufferReset <= '0';

            ExecuteBufferEnable <= '1';
            ExecuteBufferReset <= '0';

            Memory1BufferEnable <= '1';
            Memory1BufferReset <= '0';

            Memory2BufferEnable <= '1';
            Memory2BufferReset <= '0';
        ELSE
            PCEnable <= '1';
            PCReset <= '0';

            FetchBufferEnable <= '1';
            FetchBufferReset <= '0';

            DecodeBufferEnable <= '1';
            DecodeBufferReset <= '0';

            ExecuteBufferEnable <= '1';
            ExecuteBufferReset <= '0';

            Memory1BufferEnable <= '1';
            Memory1BufferReset <= '0';

            Memory2BufferEnable <= '1';
            Memory2BufferReset <= '0';
        END IF;
    END IF;
    END PROCESS;

END myHDU;