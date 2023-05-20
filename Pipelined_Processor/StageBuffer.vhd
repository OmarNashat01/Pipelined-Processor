LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY StageBuffer IS
	GENERIC (n : INTEGER := 16);
	PORT (
		clock, reset, enable : IN STD_LOGIC;
		dataIn : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		resetValue : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		dataOut : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
END StageBuffer;

ARCHITECTURE a_Buffer OF StageBuffer IS
SIGNAL data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
BEGIN
	dataOut <= data WHEN enable = '1' ELSE
				(resetValue);
	PROCESS (clock, reset)
	BEGIN
		IF rising_edge(clock) THEN
			IF reset = '1' THEN
				data <= resetValue;
			ELSIF enable = '1' THEN
				data <= dataIn;
			END IF;
		END IF;
	END PROCESS;
END a_Buffer;