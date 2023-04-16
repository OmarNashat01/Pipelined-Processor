--include

Library IEEE;
Use ieee.std_logic_1164.all;

entity controller is 
port(   op_code:in std_logic_vector(2 downto 0);
	alu_selector:out std_logic_vector(4 downto 0);
	write_enable:out std_logic);
end entity;

ARCHITECTURE imp_controller OF controller IS
BEGIN
with op_code select 
	alu_selector <= "11010" when "101",
			"00110" when "001",
			"00000" when others;

with op_code select 
	write_enable <= '1' when "101",
			'1' when "001",
			'0' when others;

END imp_controller;