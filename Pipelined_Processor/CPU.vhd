LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY CPU IS
    PORT (
        clock, reset, interrupt : IN STD_LOGIC;
        inPort : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        outPort : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE struct OF CPU IS
    -- PC
    SIGNAL pcAddressIn, pcAddressOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL pcEnable : STD_LOGIC;

    -- Instruction Cache
    SIGNAL instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Instruction Decoder
    SIGNAL decoderEnable : STD_LOGIC;
    SIGNAL decoderSignals : STD_LOGIC_VECTOR(11 DOWNTO 0);

    --- Register File
    SIGNAL WB : STD_LOGIC;
    SIGNAL writeAddress : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL registerFileDataIn : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL registerOut1, registerOut2 : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- ALU
    SIGNAL aluSecondOperand : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL aluOut : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- Data Cache
    SIGNAL dataCacheReadAddress : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL dataCacheDataIn, dataCacheDataOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    pcInst : ENTITY work.PC PORT MAP(
        clock => clock,
        enable => pcEnable,
        reset => reset,
        addressIn => pcAddressIn,
        counter => pcAddressOut
    );

    icInst : ENTITY work.InstructionCache PORT MAP(
        readAddress => pcAddressOut,
        dataOut => instruction,
        PCValid => pcEnable,
        PCAddress => pcAddressIn
    ); 

    decoderInst : ENTITY work.Decoder PORT MAP(
        enable => decoderEnable,
        opCode => instruction(31 DOWNTO 26), --removed when buffers added
        signals => decoderSignals
    );
    
    regFileInst : ENTITY work.RegisterFile PORT MAP(
        clock => clock,
        WB => WB,
        Rsrc1 => instruction(24 DOWNTO 22), --removed when buffers added
        Rsrc2 => instruction(21 DOWNTO 19), --removed when buffers added
        Rdst => writeAddress,
        dataIn => registerFileDataIn,
        Rout1 => registerOut1,
        Rout2 => registerOut2
    );

    aluInst: ENTITY work.ALU PORT MAP(
        src1 => registerOut1, --removed when buffers added
        src2 => aluSecondOperand, -- needs logic to implement
        opCode => instruction(31 downto 26), --removed when buffers added
        EX => decoderSignals(3), --removed when buffers added
        WALU => decoderSignals(7 downto 6), --removed when buffers added
        aluOut => aluOut
    );

    dataCacheInst: ENTITY work.DataCache PORT MAP(
        clock => clock,
        MEMR => decoderSignals(1), --removed when buffers added
        MEMW => decoderSignals(2), --removed when buffers added
        stackRW => decoderSignals(9 downto 8), --removed when buffers added
        readAddress => dataCacheReadAddress, -- logic needed
        dataIn => dataCacheDataIn, -- Logic needed
        dataOut => dataCacheDataOut -- Logic needed
    );


END struct;