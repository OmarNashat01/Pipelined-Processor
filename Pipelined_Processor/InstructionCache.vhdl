LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY instruction_cache IS
    GENERIC (
        addressSize : INTEGER := 16;
        ramWidth : INTEGER := 16
    );
    PORT (
        readAddress : IN STD_LOGIC_VECTOR(addressSize - 1 DOWNTO 0);
        dataOut : OUT STD_LOGIC_VECTOR(2 * ramWidth - 1 DOWNTO 0);
        PCValid : OUT STD_LOGIC; -- UNUSED SO FAR
        PCAddress : OUT STD_LOGIC_VECTOR(addressSize - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE sync_ram_a OF instruction_cache IS
    TYPE ram_type IS ARRAY(0 TO 2 ** addressSize - 1) OF STD_LOGIC_VECTOR(ramWidth - 1 DOWNTO 0);
    SIGNAL ram : ram_type;
BEGIN
    dataOut <= ram(to_integer(unsigned(readAddress))) & ram(to_integer(unsigned(readAddress)) + 1);

    -- increment PC by 1 if the instruction is 16 bits wide, otherwise increment by 2
    PCAddress <= 
        STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(readAddress)) + 1, addressSize)) WHEN ram(to_integer(unsigned((readAddress))))(31) = '0' ELSE
        STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(readAddress)) + 2, addressSize));

END sync_ram_a;