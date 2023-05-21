LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY InstructionCache IS
    GENERIC (
        addressSize : INTEGER := 16;
        ramWidth : INTEGER := 16
    );
    PORT (
        readAddress : IN STD_LOGIC_VECTOR(addressSize - 1 DOWNTO 0);
        resetAddress, interruptAddress : OUT STD_LOGIC_VECTOR(addressSize - 1 DOWNTO 0);
        dataOut : OUT STD_LOGIC_VECTOR(2 * ramWidth - 1 DOWNTO 0);
        PCAddress : OUT STD_LOGIC_VECTOR(addressSize - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE sync_ram_a OF InstructionCache IS
    TYPE ram_type IS ARRAY(0 TO 2 ** addressSize - 1) OF STD_LOGIC_VECTOR(ramWidth - 1 DOWNTO 0);
    SIGNAL ram : ram_type;
BEGIN
    resetAddress <= ram(0);
    interruptAddress <= ram(1);

    dataOut <= ram(to_integer(unsigned(readAddress))) & ram(to_integer(unsigned(readAddress)) + 1);

    -- increment PC by 1 if the instruction is 16 bits wide, otherwise increment by 2
    -- with ram(to_integer(unsigned(readAddress)))(31) select
    -- PCAddress <= 
    --     STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(readAddress)) + 1, addressSize)) WHEN '0',
    --     STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(readAddress)) + 2, addressSize)) WHEN OTHERS;
    PROCESS (readAddress)
    BEGIN
        case ram(to_integer(unsigned(readAddress)))(15) is
            when '0' => PCAddress <= STD_LOGIC_VECTOR(unsigned(readAddress) + 1);
            when OTHERS => PCAddress <= STD_LOGIC_VECTOR(unsigned(readAddress) + 2);
        end case;
    END PROCESS;

END sync_ram_a;