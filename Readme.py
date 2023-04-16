import json
from Defs import INSTRUCTIONS, SIGNALS, INSTRUCTION_TYPE



instruction_signals = { 
    INSTRUCTIONS.NOP : [],
    INSTRUCTIONS.SETC: [SIGNALS.SETC],
    INSTRUCTIONS.CLRC: [SIGNALS.CLRC],
    INSTRUCTIONS.NOT : [SIGNALS.WB, SIGNALS.EX],
    INSTRUCTIONS.INC : [SIGNALS.WB, SIGNALS.EX],
    INSTRUCTIONS.DEC : [SIGNALS.WB, SIGNALS.EX],
    INSTRUCTIONS.OUT : [SIGNALS.IOW],
    INSTRUCTIONS.IN  : [SIGNALS.WB, SIGNALS.IOR],
    INSTRUCTIONS.MOV : [SIGNALS.WB],
    INSTRUCTIONS.ADD : [SIGNALS.WB, SIGNALS.EX], # LNG
    INSTRUCTIONS.IADD: [SIGNALS.WB, SIGNALS.EX, SIGNALS.IMDT], # LNG
    INSTRUCTIONS.SUB : [SIGNALS.WB, SIGNALS.EX], # LNG
    INSTRUCTIONS.AND : [SIGNALS.WB, SIGNALS.EX], # LNG
    INSTRUCTIONS.OR  : [SIGNALS.WB, SIGNALS.EX], # LNG
    INSTRUCTIONS.PUSH: [SIGNALS.MEM, SIGNALS.DECSP],
    INSTRUCTIONS.POP : [SIGNALS.MEM, SIGNALS.INCSP],
    INSTRUCTIONS.LDM : [SIGNALS.WB, SIGNALS.IMDT], # LNG
    INSTRUCTIONS.LDD : [SIGNALS.WB, SIGNALS.MEM, SIGNALS.EX],
    INSTRUCTIONS.STD : [SIGNALS.MEM, SIGNALS.EX],
    INSTRUCTIONS.JZ  : [SIGNALS.EX],
    INSTRUCTIONS.JC  : [SIGNALS.EX],
    INSTRUCTIONS.JMP : [SIGNALS.PCJMP],
    INSTRUCTIONS.CALL: [SIGNALS.MEM, SIGNALS.DECSP, SIGNALS.PCJMP],
    INSTRUCTIONS.RET : [SIGNALS.MEM, SIGNALS.INCSP, SIGNALS.PCJMP],
    INSTRUCTIONS.RTI : [SIGNALS.WB, SIGNALS.MEM, SIGNALS.INCSP, SIGNALS.PCJMP],
}

instruction_type = {
    INSTRUCTION_TYPE.I_TYPE: (
        INSTRUCTIONS.SETC,
        INSTRUCTIONS.CLRC,
    ),

    INSTRUCTION_TYPE.R_TYPE: ( # WB, EX
        INSTRUCTIONS.NOT,
        INSTRUCTIONS.INC,
        INSTRUCTIONS.DEC,
        INSTRUCTIONS.ADD,
        INSTRUCTIONS.SUB,
        INSTRUCTIONS.AND,
        INSTRUCTIONS.OR,

        INSTRUCTIONS.IADD,
        INSTRUCTIONS.LDD,
    ),
    "SP": [ # MEM, SP 
                 # 1 bits , 1 bit for inc or dec
        INSTRUCTIONS.PUSH,
        INSTRUCTIONS.POP,
        INSTRUCTIONS.CALL,
        INSTRUCTIONS.RET,
        INSTRUCTIONS.RTI
    ],

    # PCJMP
    'PCJMP' :[  # 1 bit
        INSTRUCTIONS.JMP,
        INSTRUCTIONS.CALL,
        INSTRUCTIONS.RET,
        INSTRUCTIONS.RTI,
    ],


    INSTRUCTION_TYPE.J_TYPE: (
        INSTRUCTIONS.JMP,
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
        if signals_ and (SIGNALS.DECSP in signals_ or SIGNALS.INCSP in signals_) :
            mydict['signals'].append(str(instruction))
            
    with open('fitered.json', 'w') as f:
        json.dump(mydict, f, indent=4)

if __name__ == '__main__':
    SignalsToInstructions()
    filter_by_signals()