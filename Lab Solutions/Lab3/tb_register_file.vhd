library IEEE;
use IEEE.std_logic_1164.all;


entity tb_register_file is
end entity;

Architecture testingRegisterFile of tb_register_file is

component register_file is 
port(   input_port:in std_logic_vector(15 downto 0);
	read_address:in std_logic_vector(1 downto 0);
	write_address:in std_logic_vector(1 downto 0);
	write_enable:in std_logic;
	Rst: in std_logic;
	Clk: in std_logic;
	output_port:out std_logic_vector(15 downto 0));
end component;

Signal test_input_port: std_logic_vector(15 downto 0);
Signal test_read_address: std_logic_vector(1 downto 0);
Signal test_write_address: std_logic_vector(1 downto 0);
Signal test_write_enable: std_logic;
Signal test_Rst: std_logic;
Signal test_Clk: std_logic;
Signal test_output_port: std_logic_vector(15 downto 0);

BEGIN
U1: register_file port map (test_input_port, test_read_address, test_write_address, test_write_enable, test_Rst, test_Clk, test_output_port);
PROCESS
BEGIN
test_Clk <= '0';
wait for 5 ns;
test_Clk <= '1';
wait for 5 ns;
END PROCESS;


PROCESS
Begin
test_read_address <= "00";
test_Rst <= '1';

wait for 10 ns;

assert (test_output_port = x"0000")
	report "Failed Case 1: Out_Port: " & to_hstring(test_output_port)
	severity error;

test_Rst <= '0';
test_input_port <= x"F00F";
test_write_enable <= '1';
test_write_address <= "00";
test_read_address <= "00";

wait for 10 ns;

assert (test_output_port = x"F00F")
	report "Failed Case 2: Out_Port: " & to_hstring(test_output_port)
	severity error;

test_input_port <= x"1001";
test_write_enable <= '1';
test_write_address <= "01";
test_read_address <= "00";

wait for 10 ns;

assert (test_output_port = x"F00F")
	report "Failed Case 3: Out_Port: " & to_hstring(test_output_port)
	severity error;

test_input_port <= x"0003";
test_write_enable <= '1';
test_write_address <= "00";
test_read_address <= "01";

wait for 10 ns;

assert (test_output_port = x"1001")
	report "Failed Case 4: Out_Port: " & to_hstring(test_output_port)
	severity error;

test_write_enable <= '0';
test_read_address <= "10";

wait for 10 ns;

assert (test_output_port = x"0000")
	report "Failed Case 5: Out_Port: " & to_hstring(test_output_port)
	severity error;

test_input_port <= x"A00A";
test_write_enable <= '1';
test_write_address <= "10";
test_read_address <= "00";

wait for 10 ns;

assert (test_output_port = x"0003")
	report "Failed Case 5: Out_Port: " & to_hstring(test_output_port)
	severity error;

test_input_port <= x"B00B";
test_write_enable <= '1';
test_write_address <= "11";
test_read_address <= "01";

wait for 10 ns;

assert (test_output_port = x"1001")
	report "Failed Case 5: Out_Port: " & to_hstring(test_output_port)
	severity error;

test_write_enable <= '0';
test_read_address <= "10";

wait for 10 ns;

assert (test_output_port = x"A00A")
	report "Failed Case 5: Out_Port: " & to_hstring(test_output_port)
	severity error;


wait; 
END PROCESS;
END Architecture;