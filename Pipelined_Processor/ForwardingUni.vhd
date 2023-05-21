LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

entity ForwardingUnit is
  port (
	clock: in std_logic;
    decode_rsrc1, decode_rsrc2: in std_logic_vector(2 downto 0);
    execute_rdst, mem1_rdst, mem2_rdst: in std_logic_vector(2 downto 0);
	execute_rdst_val, mem1_rdst_val, mem2_rdst_val: in std_logic_vector(15 downto 0);
	WB_execute, WB_mem1, WB_mem2: in std_logic;
	MEMR_execute: in std_logic;
    alu_selector_rsrc1, alu_selector_rsrc2: out std_logic;  -- 0 = no forwarding, 1 = forwarding
	alu_rsrc1_val, alu_rsrc2_val: out std_logic_vector(15 downto 0);
	load_use_hazard: out std_logic
  );
end ForwardingUnit;

ARCHITECTURE imp_ForwardingUnit OF ForwardingUnit IS
BEGIN

	alu_selector_rsrc1 <= '1' WHEN (decode_rsrc1 = execute_rdst AND WB_execute = '1') ELSE
						 '1' WHEN (decode_rsrc1 = mem1_rdst AND WB_mem1 = '1') ELSE
						 '1' WHEN (decode_rsrc1 = mem2_rdst AND WB_mem2 = '1') ELSE
						 '0';

	alu_rsrc1_val <= execute_rdst_val WHEN (decode_rsrc1 = execute_rdst) ELSE
					mem1_rdst_val WHEN (decode_rsrc1 = mem1_rdst) ELSE
					mem2_rdst_val WHEN (decode_rsrc1 = mem2_rdst) ELSE
					"0000000000000000";


	alu_selector_rsrc2 <= '1' WHEN (decode_rsrc2 = execute_rdst AND WB_execute = '1') ELSE
						 '1' WHEN (decode_rsrc2 = mem1_rdst AND WB_mem1 = '1') ELSE
						 '1' WHEN (decode_rsrc2 = mem2_rdst AND WB_mem2 = '1') ELSE
						 '0';

	alu_rsrc2_val <= execute_rdst_val WHEN (decode_rsrc2 = execute_rdst) ELSE
					mem1_rdst_val WHEN (decode_rsrc2 = mem1_rdst) ELSE
					mem2_rdst_val WHEN (decode_rsrc2 = mem2_rdst) ELSE
					"0000000000000000";

	load_use_hazard <= '1' WHEN ( (decode_rsrc1 = execute_rdst OR decode_rsrc2 = execute_rdst)  AND WB_execute = '1' AND MEMR_execute = '1')
						ELSE '0';

END imp_ForwardingUnit;
