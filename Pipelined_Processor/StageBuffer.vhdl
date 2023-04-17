LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY StageBuffer IS
	GENERIC (n : INTEGER := 16);
	PORT (
		clock, reset, enable : IN STD_LOGIC;
		dataIn : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		dataOut : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
END StageBuffer;

ARCHITECTURE a_Buffer OF StageBuffer IS
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
END a_Buffer;