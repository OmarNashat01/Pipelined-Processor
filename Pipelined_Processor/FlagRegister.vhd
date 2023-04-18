LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY FlagRegister IS
	PORT (
		clock, reset, enable : IN STD_LOGIC;
		dataIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		dataOut : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END FlagRegister;

ARCHITECTURE myFRegister OF FlagRegister IS
BEGIN
	PROCESS (clock, reset)
	BEGIN
		IF rising_edge(clock) THEN
			IF reset = '1' THEN
				dataOut <= (OTHERS => '0');
			ELSIF enable = '1' THEN
				dataOut <= dataIn;
			END IF;
		END IF;
	END PROCESS;
END myFRegister;