from enum import Enum


class INSTRUCTIONS(Enum):
    NOP = 0
    SETC = 1
    CLRC = 2
    NOT = 3
    INC = 4
    DEC = 5
    OUT = 6
    IN = 7
    MOV = 8
    ADD = 9
    IADD = 10
    SUB = 11
    AND = 12
    OR = 13
    PUSH = 14
    POP = 15
    LDM = 16
    LDD = 17
    STD = 18
    JZ = 19
    JC = 20
    JMP = 21
    CALL = 22
    RET = 23
    RTI = 24

class SIGNALS(Enum):
    """
    Signals:
    
    ###### Control signals ######
    WB: Write back
    MEM: Memory
    EX: Execute

    ###### I/O signals ######
    IOR: Input read
    IOW: Output write
    
    ###### ALU signals ######
    SETC: Set carry
    CLRC: Clear carry
    
    ###### Stack signals ######
    INCSP: Increment stack pointer
    DECSP: Decrement stack pointer

    ###### PC signals ######
    PCJMP: Branching


    ###### Immediate signals ######
    IMDT: Immediate

    ###### Long instruction (32-bits) ######
    ###### Used to determine if another increment to the PC is needed ######
    LNG: Long

    """
    WB = 0
    MEM = 1
    EX = 2
    IOR = 3
    IOW = 4
    SETC = 5
    CLRC = 6
    INCSP = 7
    DECSP = 8
    PCJMP = 9
    IMDT = 10
    LNG = 11


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