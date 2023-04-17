LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RegisterFile IS
    PORT (
        clock: IN STD_LOGIC;
        WB : IN STD_LOGIC;
        Rsrc1, Rsrc2, Rdst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        dataIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        Rout1, Rout2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE mem_reg OF RegisterFile IS
    TYPE ram_type IS ARRAY(0 TO 7) of std_logic_vector(15 DOWNTO 0);
    SIGNAL ram : ram_type := (OTHERS => (OTHERS => '0'));
BEGIN
    process (clock)
    begin
        if falling_edge(clock) then
            if WB = '1' then
                ram(to_integer(unsigned(Rdst))) <= dataIn;
            end if;
        end if;
    end process;

    Rout1 <= ram(to_integer(unsigned(Rsrc1)));
    Rout2 <= ram(to_integer(unsigned(Rsrc2)));
END mem_reg;