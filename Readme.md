
# Assumptions

* Conditional jumps will only use EX signal and if hazard is detected, the hazard detection unit will be notified to change the PC and flush the pipeline.

* MAX number of bits for OP code is 7 bits.

* we increment PC by one and another one if 32 bits instruction is detected (in FETCH).


OP code
(32 or 16 bit instruction) (rtype) (type) 

## OPCODES
---
1-bit:
    -0 : 16 bit instruction
    -1 : 32 bit instruction
2-bits:
    -00 : type 0
    -01 : type 1
    -10 : type 2
    -11 : type 3 
3-bits:
    - type 0:
      - identifier for each instruction
    - SP type:
      - 
---
(32 or 16 bit instruction) (type) (JMP: 1 bit)

(32 or 16 bit instruction) ==> 0 for 16 bit, 1 for 32 bit
(type) ==> 10 for R type, 11 for XXX, 0X for SP (X ==> 1 for inc , 0 for dec)


# Components

## PC:
> PORTS: 
> - clock, enable, reset (1-bit)
> - addressIn (16-bit)
> - counter(16-bit)

#### brief:
* 16 bit
* doesn't increment internally
* takes next value from addressIn


## Instruction Cache:
> PORTS: 
> - readAddress (16-bit)
> - dataOut (32-bit)
> - PCAddress (16-bit)

#### brief:
* 1k * 16 bit
* outputs 32 bit data
* outputs next address for PC

## Register File:
> PORTS:
> - clock, WB (1-bit)
> - Rs1, Rs2, Rdst (3-bit)
> - dataIn (16-bit)
> - Rout1, Rout2 (16-bit)

#### brief:






## ALU: