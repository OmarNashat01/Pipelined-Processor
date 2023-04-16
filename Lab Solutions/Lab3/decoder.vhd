--include

Library IEEE;
Use ieee.std_logic_1164.all;
 
entity decoder is
port(
 En: STD_LOGIC;
 a : in STD_LOGIC_VECTOR(1 downto 0);
 b : out STD_LOGIC_VECTOR(3 downto 0)
 );
end decoder;
 
architecture a_decoder of decoder is
begin
 
process(a)
begin
 if (En='1') then
 	if (a="00") then
 	b <= "0001";
 	elsif (a="01") then
 	b <= "0010";
 	elsif (a="10") then
 	b <= "0100";
 	else
 	b <= "1000";
 	end if;
 else
	b <= "0000";
end if;
end process;
END a_decoder;