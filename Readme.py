import json
from Defs import INSTRUCTIONS, SIGNALS, INSTRUCTION_TYPE



# instruction_signals = { 
#     INSTRUCTIONS.NOP : [],
#     INSTRUCTIONS.SETC: [SIGNALS.WALU],
#     INSTRUCTIONS.CLRC: [SIGNALS.WALU],
#     INSTRUCTIONS.NOT : [SIGNALS.WB],# SIGNALS.EX
#     INSTRUCTIONS.INC : [SIGNALS.WB],# SIGNALS.EX
#     INSTRUCTIONS.DEC : [SIGNALS.WB],# SIGNALS.EX
#     INSTRUCTIONS.OUT : [SIGNALS.IOW],
#     INSTRUCTIONS.IN  : [SIGNALS.WB, SIGNALS.IOR],
#     INSTRUCTIONS.MOV : [SIGNALS.WB],
#     INSTRUCTIONS.ADD : [SIGNALS.WB], # LNG, SIGNALS.EX
#     INSTRUCTIONS.IADD: [SIGNALS.WB], # LNG, SIGNALS.EX
#     INSTRUCTIONS.SUB : [SIGNALS.WB], # LNG, SIGNALS.EX
#     INSTRUCTIONS.AND : [SIGNALS.WB], # LNG, SIGNALS.EX
#     INSTRUCTIONS.OR  : [SIGNALS.WB], # LNG, SIGNALS.EX
#     INSTRUCTIONS.PUSH: [SIGNALS.MEMW, SIGNALS.DECSP],
#     INSTRUCTIONS.POP : [SIGNALS.WB, SIGNALS.MEMW, SIGNALS.INCSP],
#     INSTRUCTIONS.LDM : [SIGNALS.WB], # LNG
#     INSTRUCTIONS.LDD : [SIGNALS.WB, SIGNALS.MEM], # , SIGNALS.EX
#     INSTRUCTIONS.STD : [SIGNALS.MEM], # , SIGNALS.EX
#     INSTRUCTIONS.JZ  : [], # [SIGNALS.EX],
#     INSTRUCTIONS.JC  : [], # [SIGNALS.EX],
#     INSTRUCTIONS.JMP : [SIGNALS.PCJMP],
#     INSTRUCTIONS.CALL: [SIGNALS.MEM, SIGNALS.DECSP, SIGNALS.PCJMP],
#     INSTRUCTIONS.RET : [SIGNALS.MEM, SIGNALS.INCSP, SIGNALS.PCJMP],
#     INSTRUCTIONS.RTI : [SIGNALS.MEM, SIGNALS.INCSP, SIGNALS.PCJMP, SIGNALS.WALU],
# }


instructions = {
    INSTRUCTIONS.NOT : [SIGNALS.WB],# SIGNALS.EX
    INSTRUCTIONS.INC : [SIGNALS.WB],# SIGNALS.EX
    INSTRUCTIONS.DEC : [SIGNALS.WB],# SIGNALS.EX
    INSTRUCTIONS.ADD : [SIGNALS.WB], # LNG, SIGNALS.EX
    INSTRUCTIONS.IADD: [SIGNALS.WB], # LNG, SIGNALS.EX
    INSTRUCTIONS.SUB : [SIGNALS.WB], # LNG, SIGNALS.EX
    INSTRUCTIONS.AND : [SIGNALS.WB], # LNG, SIGNALS.EX
    INSTRUCTIONS.OR  : [SIGNALS.WB], # LNG, SIGNALS.EX


    INSTRUCTIONS.MOV : [SIGNALS.WB],
    INSTRUCTIONS.LDM : [SIGNALS.WB], # LNG
    INSTRUCTIONS.LDD : [SIGNALS.WB, SIGNALS.MEMR],
    INSTRUCTIONS.POP : [SIGNALS.WB, SIGNALS.MEMR, SIGNALS.INCSP],
    INSTRUCTIONS.IN  : [SIGNALS.WB, SIGNALS.IOR],



    INSTRUCTIONS.NOP : [],
    INSTRUCTIONS.JZ  : [],
    INSTRUCTIONS.JC  : [],

    INSTRUCTIONS.SETC: [SIGNALS.WALU],
    INSTRUCTIONS.CLRC: [SIGNALS.WALU],
    INSTRUCTIONS.OUT : [              SIGNALS.IOW],
    INSTRUCTIONS.JMP : [                           SIGNALS.PCJMP],



    INSTRUCTIONS.STD : [SIGNALS.MEMW],
    INSTRUCTIONS.PUSH: [SIGNALS.MEMW, SIGNALS.DECSP],
    INSTRUCTIONS.CALL: [SIGNALS.MEMW, SIGNALS.DECSP,                SIGNALS.PCJMP],

    INSTRUCTIONS.RET : [SIGNALS.MEMR,                SIGNALS.INCSP, SIGNALS.PCJMP],
    INSTRUCTIONS.RTI : [SIGNALS.MEMR,                SIGNALS.INCSP, SIGNALS.PCJMP, SIGNALS.WALU],
}







instruction_type = {
    'MISC': (
        INSTRUCTIONS.NOP,
        INSTRUCTIONS.JZ,
        INSTRUCTIONS.JC,

        INSTRUCTIONS.IN,
        INSTRUCTIONS.OUT,
        INSTRUCTIONS.SETC,
        INSTRUCTIONS.CLRC,
        INSTRUCTIONS.JMP,
    ),
    INSTRUCTION_TYPE.R_TYPE: ( # WB
        INSTRUCTIONS.NOT,
        INSTRUCTIONS.INC,
        INSTRUCTIONS.DEC,
        INSTRUCTIONS.MOV,
        INSTRUCTIONS.SUB,
        INSTRUCTIONS.AND,
        INSTRUCTIONS.OR,
        INSTRUCTIONS.ADD,
        INSTRUCTIONS.IADD,
        INSTRUCTIONS.LDM,

        INSTRUCTIONS.LDD, #==> mem
    ),

    'MEM': (
        INSTRUCTIONS.PUSH,
        INSTRUCTIONS.POP,
        INSTRUCTIONS.STD,
        INSTRUCTIONS.CALL,
        INSTRUCTIONS.RET,
        INSTRUCTIONS.RTI,
    ),
}

def SignalsToInstructions():

    signals_dict = {}
    for instruction, signals in instruction_signals.items():
        signals = str(signals)
        if signals not in signals_dict:
            signals_dict[signals] = []
        signals_dict[signals].append(str(instruction))

    with open('SignalsToInstructions.json', 'w') as f:
        json.dump(signals_dict, f, indent=4)

def filter_by_signals():
    mydict = {
        'signals': []
    }
    for instruction, signals_ in instruction_signals.items():
        if signals_ and (SIGNALS.MEM in signals_ or SIGNALS.MEM in signals_) :
            mydict['signals'].append(str(instruction))
            
    with open('fitered.json', 'w') as f:
        json.dump(mydict, f, indent=4)

if __name__ == '__main__':
    SignalsToInstructions()
    filter_by_signals()