LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY HDU IS
    GENERIC (N : INTEGER := 16);
    PORT (
        clock : IN STD_LOGIC;
        -- Load Use Case
        loadUseHazard : IN STD_LOGIC;

        -- Structural Hazards
        MEMWR_DECODE, MEMWR_EX : IN STD_LOGIC_VECTOR(1 DOWNTO 0);


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
    -- PCReset <= '0';
    -- FetchBufferReset <= '0';
    -- ExecuteBufferReset <= '0';
    -- Memory1BufferReset <= '0';
    -- Memory2BufferReset <= '0';

    -- FetchBufferEnable <= '0' WHEN loadUseHazard = '1' ELSE 
    --                     '0' WHEN unsigned(MEMWR_EX) > 0 AND unsigned(MEMWR_MEM) > 0 ELSE
    --                     '1';
    
    -- DecodeBufferEnable <= '0' WHEN loadUseHazard = '1' ELSE
    --                     '0' WHEN unsigned(MEMWR_EX) > 0 AND unsigned(MEMWR_MEM) > 0 ELSE
    --                     '1';
    
    -- ExecuteBufferEnable <= '1' WHEN loadUseHazard = '1' ELSE
    --                     '0' WHEN unsigned(MEMWR_EX) > 0 AND unsigned(MEMWR_MEM) > 0 ELSE
    --                     '1';
    
    -- Memory1BufferEnable <= '1';
    -- Memory2BufferEnable <= '1';

    PROCESS (loadUseHazard, clock)
    BEGIN
    IF falling_edge(clock) THEN
        IF loadUseHazard = '1' OR (unsigned(MEMWR_EX) > 0 AND unsigned(MEMWR_DECODE) > 0) THEN -- Data Hazard and Structural Hazard
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
        
        ELSE -- No Hazard
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