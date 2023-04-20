
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

def assembly_to_binary(filename :str):

    with open(filename, "r") as f:
        with open(filename+".bin", "w") as f2:
            lines = f.readlines()
            for line in lines:
                line = line.strip()
                if line == "":
                    continue
                if line[0] == "#":
                    continue
                if line[0] == ".":
                    continue

                line = line.split(" ")
                lineout = ""
                c = 0
                for l in line:
                    l = l.strip()
                    if l == "":
                        continue
                    if l[0] == "#":
                        break
                    if l in assembler:
                        c += 1
                        lineout += (assembler[l.upper()] + "X")
                    else:
                        regs = l.split(',')
                        for reg in regs:
                            if (reg not in registers):
                                continue
                            c += 1
                            lineout += (registers[reg.upper()])

                f2.write("0" + lineout + "XXX"*(4-c) + "\n")


    



if __name__ == "__main__":
    assembly_to_binary("code.asm")

