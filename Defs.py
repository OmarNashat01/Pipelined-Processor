from enum import Enum
import re
import sys

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
    INC = "00000"
    ADD = "00001"
    IADD = "00001"
    SUB = "00010"
    DEC = "00011"

    AND = "00101"
    OR = "00110"
    NOT = "00111"

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


lng_instruction = ["IADD", "LDM"]
assembler = {
    "NOP": [INSTRUCTIONS.NOP.value,],
    "SETC": [INSTRUCTIONS.SETC.value,],
    "CLRC":[ INSTRUCTIONS.CLRC.value,],
    "NOT": [INSTRUCTIONS.NOT.value,],
    "INC": [INSTRUCTIONS.INC.value,],
    "DEC": [INSTRUCTIONS.DEC.value,],
    "OUT": [INSTRUCTIONS.OUT.value,"XXX"],
    "IN": [INSTRUCTIONS.IN.value,],
    "MOV": [INSTRUCTIONS.MOV.value,],
    "ADD": [INSTRUCTIONS.ADD.value,],
    "IADD":[ INSTRUCTIONS.IADD.value,],
    "SUB": [INSTRUCTIONS.SUB.value,],
    "AND": [INSTRUCTIONS.AND.value,],
    "OR": [INSTRUCTIONS.OR.value,],
    "PUSH": [INSTRUCTIONS.PUSH.value,"XXX"],
    "POP": [INSTRUCTIONS.POP.value,],
    "LDM": [INSTRUCTIONS.LDM.value,],
    "LDD": [INSTRUCTIONS.LDD.value,],
    "STD": [INSTRUCTIONS.STD.value, "XXX"],
    "JZ": [INSTRUCTIONS.JZ.value,],
    "JC": [INSTRUCTIONS.JC.value,],
    "JMP": [INSTRUCTIONS.JMP.value,],
    "CALL":[ INSTRUCTIONS.CALL.value,],
    "RET": [INSTRUCTIONS.RET.value,],
    "RTI": [INSTRUCTIONS.RTI.value,],
}
registers = {
    "R0": "000",
    "R1": "001",
    "R2": "010",
    "R3": "011",
    "R4": "100",
    "R5": "101",
    "R6": "110",
    "R7": "111",
}

header = """
// memory data file (do not edit the following line - required for mem load use)
// instance=/cpu/icInst/ram
// format=mti addressradix=h dataradix=s version=1.0 wordsperline=1"""

def assembly_to_binary(filename :str):
    outFileDict = {}
    line_number = 0
    last_org = False
    regex = re.compile(r"^(\w|\.).*")
    with open(filename, "r", encoding="utf-8") as f:
        with open(filename+".bin", "w") as f2:
            # Headers for mem file
            f2.writelines(header[1:]+"\n")
            lines = iter(f.readlines())
            for line in lines:
                if last_org and line[0].isdigit():
                    num_to_write = line.split("#")[0].strip()
                    outFileDict[line_number] = "0" * (16 - len(num_to_write)) + num_to_write + "\n"
                    line_number += 1
                    last_org = False
                    continue
                match = re.match(r"(^\w|^\.).*", line)
                match = regex.search(line)

                if not match:
                    continue
                line = match.group(0).split('#')[0].strip()
                if not line or line == "":
                    continue
                if line[0] == ".":
                    line = line.split()
                    line_number = int(line[1],16) # get the line number and cast it from hex to decimal
                    last_org = True

                    continue

                line = line.split(",")
                line = [l.strip() for l in line]
                line = line[0].split(" ") + line[1:]
                # print(line)
                lineout = ""
                rdst_missing = False
                lng = False

                if (len(assembler[line[0].upper().strip()]) == 2):
                    rdst_missing = True
                if (line[0].upper().strip() in lng_instruction):
                    lng = True
                lineout += (''.join(assembler[line[0].upper().strip()]) + "X")

                c = 1
                for l in line[1:]:
                    if (l not in registers):
                        continue
                    c += 1
                    lineout += (registers[l.upper()])


                # start = '%04s: ' % str(hex(line_number))[2:]
                outFileDict[line_number] =  str(int(lng)) + lineout + "XXX"*(4-c - rdst_missing) + "\n"
                if (lng):
                    line_number += 1
                    outFileDict[line_number] = "0" * (16 - len(line[-1])) + line[-1] + "\n"

                line_number += 1

            for i in range(max(outFileDict.keys())+1):
                start = '%{max_number_digits}s: '.format(max_number_digits=len(str(hex(max(outFileDict.keys())+1)))-2) % str(hex(i))[2:]
                f2.writelines(start)
                if i in outFileDict:
                    f2.writelines(outFileDict[i])
                else:
                    f2.writelines("X"*16+"\n")





if __name__ == "__main__":
    assembly_to_binary(sys.argv[1])

