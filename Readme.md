

# Assumptions

* Conditional jumps will only use EX signal and if hazard is detected, the hazard detection unit will be notified to change the PC and flush the pipeline.

* MAX number of bits for OP code is 10 bits.

* we increment PC by one and another one if 32 bits instruction is detected (in FETCH).


OP code
(32 or 16 bit instruction) (rtype) (type) 

OPCODES
(32 or 16 bit instruction) (type)

(32 or 16 bit instruction) ==> 0 for 16 bit, 1 for 32 bit
(type) ==> 10 for R type, 11 for XXX, 0X for SP (X ==> 1 for inc , 0 for dec)

