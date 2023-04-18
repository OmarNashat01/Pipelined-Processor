LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

-- TODO: check data valid or no signals output
-- Works on 2 stages
-- * stage 0: read/write data
-- * stage 1: update stack pointer
ENTITY DataCache IS
    GENERIC (
        addressSize : INTEGER := 16;
        ramWidth : INTEGER := 16
    );
    PORT (
        clock : IN STD_LOGIC;
        MEMR, MEMW : IN STD_LOGIC;
        stackRW : IN STD_LOGIC_VECTOR(1 DOWNTO 0); --(00)|(11) no change, (01) push, (10) pop
        readAddress : IN STD_LOGIC_VECTOR(addressSize - 1 DOWNTO 0);
        dataIn : IN STD_LOGIC_VECTOR(ramWidth - 1 DOWNTO 0);
        dataOut : OUT STD_LOGIC_VECTOR(ramWidth - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE sync_ram_a OF DataCache IS
    TYPE ram_type IS ARRAY(0 TO 2 ** addressSize - 1) OF STD_LOGIC_VECTOR(ramWidth - 1 DOWNTO 0);
    SIGNAL ram : ram_type;

    -- TODO: CHECKKKKK IFF WORRKKSSS
    SIGNAL stackPointer : STD_LOGIC_VECTOR(addressSize - 1 DOWNTO 0) := (OTHERS => x'FFFE');
BEGIN
    PROCESS (clock)
        VARIABLE stage : STD_LOGIC := '0'; --0 stage 0 , 1 stage 1
    BEGIN
        IF rising_edge(clock) THEN
            IF stage = '0' THEN
                stage := '1';
                CASE stackRW IS
                    WHEN "01" => -- push
                        ram(to_integer(unsigned(stackPointer))) <= dataIn;
                        dataOut <= ram(to_integer(unsigned(readAddress)));

                    WHEN "10" => -- pop
                        dataOut <= ram(to_integer(unsigned(stackPointer)));

                    WHEN OTHERS => -- memory operations without stack
                        IF MEMW = '1' THEN
                            ram(to_integer(unsigned(readAddress))) <= dataIn;
                        END IF;

                        -- MEMR only works to tell me if i should cache new data if address not found cached memory
                        -- Out of scope here
                        -- IF MEMR = '1' THEN
                        dataOut <= ram(to_integer(unsigned(readAddress)));
                        -- END IF;

                END CASE;
            ELSE
                stage := '0';
                CASE stackRW IS
                    WHEN "01" =>
                        stackPointer <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(stackPointer) - 1), addressSize));
                    WHEN "10" =>
                        stackPointer <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(stackPointer) + 1), addressSize));

                    -- Doesnt need to write it (default behaviour will latch)
                    -- only for readability
                    WHEN OTHERS =>
                        stackPointer <= stackPointer;
                    
                END CASE;
            END IF;
        END IF;
    END PROCESS;
END sync_ram_a;