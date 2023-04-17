from enum import Enum


class INSTRUCTIONS(Enum):
    """
    ## Type 0: (00)
        - WB: 1
        - EX: 1
        - others: 0

    ## Type 1: (01)
        - WB: 1
        - MEMR: code(1)
        - IOR: code(2)
        - others: 0
    
    ## Type 2: (10)
        - MEMW: !code(2) 
        - MEMR: code(2)
        - DECSP: !code(2) & code(1) 
        - INCSP: code(2)
        - PCJMP: code(0)

    ## Type 3: (11)
        - all: 0 if !code(2)
    """
    NOT = "00000"
    INC = "00001"
    DEC = "00010"
    ADD = "00011"
    IADD = "00011"
    SUB = "00100"
    AND = "00101"
    OR = "00110"

    """
    Type 1: (01)
        - WB: 1
        - MEMR: code(1)
        - IOR: code(2)
        - INCSP: code(1) & code(0)
        - others: 0
    """
    MOV = "01000"
    LDM = "01001"
    LDD = "01010"
    POP = "01011" 
    IN =  "01100"


    """
    Type 2: (10)
        - MEMW: !code(2) 
        - MEMR: code(2)
        - DECSP: !code(2) & code(1) 
        - INCSP: code(2)
        - PCJMP: code(0)
    """ 
    STD =  "10000"
    PUSH = "10010"
    CALL = "10011"

    RET =  "10101"
    RTI =  "10111" #WALU


    """
    Type 3: (11)
        - all: 0 if !code(2)
    """ 
    NOP =  "11000"
    JZ =   "11001" 
    JC =   "11010"

    SETC = "11100"
    CLRC = "11101"
    OUT =  "11110"
    JMP =  "11111"


class SIGNALS(Enum):
    """
    Signals:
    
    ## Control signals
    - WB: Write back
    - MEM: Memory
    - EX: Execute (change flags)

    ## I/O signals
    - IOR: Input read
    - IOW: Output write
    
    ## ALU signals
    - WALU: 2bits (00: OFF, 01: write from port, 10: CLRC, 11: SETC)
    SETC: Set carry XX
    CLRC: Clear carry XX
    
    ## Stack signals
    - INCSP: Increment stack pointer
    - DECSP: Decrement stack pointer

    ## PC signals
    - PCJMP: Branching


    ## Immediate signals
    - IMDT: Immediate

    ###### Long instruction (32-bits) ######
    ###### Used to determine if another increment to the PC is needed ######
    LNG: Long

    """
    WB = 0
    MEMR = 1
    MEMW = 2
    EX = 3
    IOR = 4
    IOW = 5
    WALU = 6
    INCSP = 8
    DECSP = 9
    PCJMP = 10
    IMDT = 11
    LNG = 12


class INSTRUCTION_TYPE(Enum):
    """
    Instruction types:
    I_TYPE: Immediate (2 registers)
    R_TYPE: Register (3 registers)
    J_TYPE: Jump (unconditional jmp)
    """
    I_TYPE = 0
    R_TYPE = 1
    J_TYPE = 2


assembler = {
    "NOP": INSTRUCTIONS.NOP.value,
    "SETC": INSTRUCTIONS.SETC.value,
    "CLRC": INSTRUCTIONS.CLRC.value,
    "NOT": INSTRUCTIONS.NOT.value,
    "INC": INSTRUCTIONS.INC.value,
    "DEC": INSTRUCTIONS.DEC.value,
    "OUT": INSTRUCTIONS.OUT.value,
    "IN": INSTRUCTIONS.IN.value,
    "MOV": INSTRUCTIONS.MOV.value,
    "ADD": INSTRUCTIONS.ADD.value,
    "IADD": INSTRUCTIONS.IADD.value,
    "SUB": INSTRUCTIONS.SUB.value,
    "AND": INSTRUCTIONS.AND.value,
    "OR": INSTRUCTIONS.OR.value,
    "PUSH": INSTRUCTIONS.PUSH.value,
    "POP": INSTRUCTIONS.POP.value,
    "LDM": INSTRUCTIONS.LDM.value,
    "LDD": INSTRUCTIONS.LDD.value,
    "STD": INSTRUCTIONS.STD.value,
    "JZ": INSTRUCTIONS.JZ.value,
    "JC": INSTRUCTIONS.JC.value,
    "JMP": INSTRUCTIONS.JMP.value,
    "CALL": INSTRUCTIONS.CALL.value,
    "RET": INSTRUCTIONS.RET.value,
    "RTI": INSTRUCTIONS.RTI.value,
}

print(assembler["NOP"].value)

