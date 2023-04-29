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

    -- Signals for Buffer Bubbles
    SIGNAL fetchBubble : STD_LOGIC_VECTOR(47 DOWNTO 0) := x"XXXX60XXXXXX";
    SIGNAL decodeBubble : STD_LOGIC_VECTOR(91 DOWNTO 0) := x"XXXX60XXXXXX000XXXXXXXX";
    SIGNAL executeBubble : STD_LOGIC_VECTOR(73 DOWNTO 0) := (OTHERS => '0');
    SIGNAL dataCache1Bubble : STD_LOGIC_VECTOR(39 DOWNTO 0) := (OTHERS => '0');
    SIGNAL dataCache2Bubble : STD_LOGIC_VECTOR(37 DOWNTO 0) := (OTHERS => '0');

    -- PC
    SIGNAL pcAddressIn, pcAddressOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL pcEnable : STD_LOGIC;

    -- Instruction Cache
    SIGNAL instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Fetch Buffer
    SIGNAL fetchBufferEnable : STD_LOGIC;
    SIGNAL fetchBufferOut : STD_LOGIC_VECTOR(47 DOWNTO 0);
    SIGNAL fetchBufferDataIn : STD_LOGIC_VECTOR(47 DOWNTO 0);

    -- Instruction Decoder
    SIGNAL decoderEnable : STD_LOGIC; -- if 0 then nop is inserted
    SIGNAL decoderSignals : STD_LOGIC_VECTOR(11 DOWNTO 0);

    --- Register File
    SIGNAL WB : STD_LOGIC;
    SIGNAL writeAddress : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL registerFileDataIn : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL registerOut1, registerOut2 : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- decode buffer
    SIGNAL decodeBufferEnable : STD_LOGIC;
    SIGNAL decodeBufferOut : STD_LOGIC_VECTOR(91 DOWNTO 0);
    SIGNAL decodeBufferDataIn : STD_LOGIC_VECTOR(91 DOWNTO 0);

    -- ALU
    SIGNAL aluSecondOperand : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL aluOut : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- Execute Buffer
    SIGNAL executeBufferEnable : STD_LOGIC;
    SIGNAL executeBufferOut : STD_LOGIC_VECTOR(73 DOWNTO 0);
    SIGNAL executeBufferDataIn : STD_LOGIC_VECTOR(73 DOWNTO 0);

    -- Data Cache
    SIGNAL dataCacheReadAddress : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL dataCacheDataIn, dataCacheDataOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL dataOrAluOut : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- Data Cache Buffer1
    SIGNAL dataCacheBuffer1Enable : STD_LOGIC;
    SIGNAL dataCacheBuffer1DataOut : STD_LOGIC_VECTOR(39 DOWNTO 0);
    SIGNAL dataCacheBuffer1DataIn : STD_LOGIC_VECTOR(39 DOWNTO 0);

    -- Data Cache Buffer2
    SIGNAL dataCacheBuffer2Enable : STD_LOGIC;
    SIGNAL dataCacheBuffer2DataOut : STD_LOGIC_VECTOR(37 DOWNTO 0);
    SIGNAL dataCacheBuffer2DataIn : STD_LOGIC_VECTOR(37 DOWNTO 0);

BEGIN
    pcEnable <= '1'; -- always enabled cuz no hazards 
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
        PCAddress => pcAddressIn
    ); 

    fetchBufferDataIn <= inPort & instruction;
    -- Always enabled cuz no hazards
    fetchBufferEnable <= '1';
    fetchBufferInst : ENTITY work.StageBuffer GENERIC MAP( n => 48 ) PORT MAP(
        clock => clock,
        reset => reset,
        enable => fetchBufferEnable,
        dataIn => fetchBufferDataIn,
        resetValue => fetchBubble,
        dataOut => fetchBufferOut
    );

    decoderEnable <= '1';
    decoderInst : ENTITY work.Decoder PORT MAP(
        enable => decoderEnable,
        opCode => fetchBufferOut(31 DOWNTO 26),
        signals => decoderSignals
    );
    
    writeAddress <= dataCacheBuffer2DataOut(20 DOWNTO 18);
    WB <= dataCacheBuffer2DataOut(16);
    
    -- MUX for Data into register file
    with dataCacheBuffer2DataOut(21) select -- IOR
    registerFileDataIn <= 
        dataCacheBuffer2DataOut(37 downto 22)  when '1', -- 16 bit Input port
        dataCacheBuffer2DataOut(15 downto 0) when OTHERS; -- 16 bit Data out

    regFileInst : ENTITY work.RegisterFile PORT MAP(
        clock => clock,
        WB => dataCacheBuffer2DataOut(16),
        Rsrc1 => fetchBufferOut(21 DOWNTO 19),
        Rsrc2 => fetchBufferOut(18 DOWNTO 16),
        Rdst => writeAddress,
        dataIn => registerFileDataIn,           -- logic from output
        Rout1 => registerOut1,
        Rout2 => registerOut2
    );

    -- Always enabled cuz no hazards
    decodeBufferEnable <= '1';
    --91 downto 76     75 downto 44       43 downto 32    31 downto 16   15 downto 0
    --(16bit input) (32bit instruction) (12bits signals) (16 dataout1)  (16 dataout2)
    decodeBufferDataIn <= (fetchBufferOut & decoderSignals & registerOut1 & registerOut2);
    decodeBufferInst: ENTITY work.StageBuffer GENERIC MAP( n => 92 ) PORT MAP(
        clock => clock,
        reset => reset,
        enable => decodeBufferEnable,
        dataIn => decodeBufferDataIn,
        resetValue => decodeBubble,
        dataOut => decodeBufferOut
    );

    -- MUX for ALU second operand
    -- TODO2: add logic for forwarding here (FU)
    with decodeBufferOut(75) select     -- LNG
        aluSecondOperand <= 
            decodeBufferOut(59 downto 44) when '1',
            decodeBufferOut(15 downto 0) when OTHERS;



    aluInst: ENTITY work.ALU PORT MAP(
        src1 => decodeBufferOut(31 downto 16),
        src2 => aluSecondOperand,
        opCode => decodeBufferOut(72 downto 70),
        EX => decodeBufferOut(35),
        WALU => decodeBufferOut(39 downto 38), 
        aluOut => aluOut
    );

    -- Always enabled cuz no hazards
    executeBufferEnable <= '1';
    -- 73 downto 58    57     56 downto 54  53 downto 52      51         50 downto 48       47 downto 32      31 downto 16        15 downto 0
    --(16bit input)(1bit IOR) (3bit Rdst) (2bit stackRW) (1bit IOW) (3bit MEMW, MEMR, WB) (16bit aluOut) (16bit registerOut1) (16bit registerOut2)
    executeBufferDataIn <= (
            decodeBufferOut(91 downto 76) & -- 16bit input
            decodeBufferOut(36) &           -- IOR
            decodeBufferOut(68 downto 66) & -- Rdst
            decodeBufferOut(41 downto 40) &
            decodeBufferOut(37) &
            decodeBufferOut(34 downto 32) &
            aluOut &
            decodeBufferOut(31 downto 0)    -- registerOut1 (16bit) & registerOut2 (16bit)
    );

    executeBufferInst: ENTITY work.StageBuffer GENERIC MAP( n => 74 ) PORT MAP(
        clock => clock,
        reset => reset,
        enable => executeBufferEnable,
        dataIn => executeBufferDataIn,
        resetValue => executeBubble,
        dataOut => executeBufferOut
    );


    dataCacheInst: ENTITY work.DataCache PORT MAP(
        clock => clock,
        MEMR => executeBufferOut(49),
        MEMW => executeBufferOut(50),
        stackRW => executeBufferOut(53 downto 52),
        readAddress => executeBufferOut(31 downto 16),
       -- dataIn => executeBufferOut(47 downto 32),
        dataIn => executeBufferOut(15 downto 0),
        dataOut => dataCacheDataOut 
    );


    -- Always enabled cuz no hazards
    dataCacheBuffer1Enable <= '1';
    with executeBufferOut(49) select     -- MEMR
    dataOrAluOut <=
        dataCacheDataOut when '1',
        executeBufferOut(47 downto 32) when OTHERS;

    --(16bit input) (IOR) (MEMW) (MEMR) (3bit Rdst) (1bit IOW) (1bit WB) (16bit out)
    dataCacheBuffer1DataIn <=
        executeBufferOut(73 downto 58) &
        executeBufferOut(57) &
        executeBufferOut(50) &
        executeBufferOut(49) &
        executeBufferOut(56 downto 54) &
        executeBufferOut(51) &
        executeBufferOut(48) &
        dataOrAluOut;

    dataCacheBuffer1Inst: ENTITY work.StageBuffer GENERIC MAP( n => 40 ) PORT MAP(
        clock => clock,
        reset => reset,
        enable => dataCacheBuffer1Enable,
        dataIn => dataCacheBuffer1DataIn,
        resetValue => dataCache1Bubble,
        dataOut => dataCacheBuffer1DataOut
    );

    -- (16bit input) (IOR) (3bit Rdst) (1bit IOW) (1bit WB) (16bit out)
    dataCacheBuffer2DataIn <= 
        dataCacheBuffer1DataOut(39 downto 24) &
        dataCacheBuffer1DataOut(23) & 
        dataCacheBuffer1DataOut(20 downto 0);
    
    -- Always enabled cuz no hazards
    dataCacheBuffer2Enable <= '1';
    dataCacheBuffer2Inst: ENTITY work.StageBuffer GENERIC MAP( n => 38 ) PORT MAP(
        clock => clock,
        reset => reset,
        enable => dataCacheBuffer2Enable,
        dataIn => dataCacheBuffer2DataIn,
        resetValue => dataCache2Bubble,
        dataOut => dataCacheBuffer2DataOut
    );

    outPort <= dataCacheBuffer2DataOut(15 downto 0);


END struct;