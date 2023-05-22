#########################################################
#        All numbers are in hex format   				#
#########################################################
#########################################################
#        We always start by reset signal 				#
#########################################################
#         This is a commented line
#        You should ignore empty lines and commented ones
# ---------- Don't forget to Reset before you start anything ---------- #


.org 0						#means the next line is at address 0 (hex)
100							# data value 100hex so memory content M[0]=100h
.org 1
20							# data value 20hex so memory content M[1]=20h
                      
.org 20
SETC						# this instruction should be at address 20h
NOT R1,R2					# this instruction should be at address 21h
INC R2,R3					# this instruction should be at address 22h
IADD R3,R2,100 				# this instruction should be at address 23h & 24h, 100 is hex format (256 decimal)
RTI							# this instruction should be at address 25h

.org 100
IN R5                        #R5= FFFE --> add FFFE on the in port, flags no change        
INC R5,R5                 #R5 = FFFF, C--> 0, N --> 1, Z --> 0
INC R5,R5                 #R5 = 0000, C--> 1, N --> 0, Z --> 1
IN R1                        #R1= 0001 --> add 0001 on the in port, flags no change        
IN R2                        #R2= 000F -> add 000F on the in port, flags no change        
IN R3                        #R3= 00C8 -> add 00C8 on the in port, flags no change        
IN R4                        #R4=001F -> add 001F on the in port, flags no change
IN R5                        #R5=00FC -> add 00FC on the in port, flags no change
PUSH R2
PUSH R1
POP R2 
POP R1
LDD R7, R1                      #R7 = M[200] = 001F    
INC R7, R7                 
NOP  
NOP                              #Flags no change
STD R1,R2                  #M[1] = 000F  //R2 is data, R1 is the address
NOP
NOP
STD R3,R4                      #M[200] = 001F, R3 --> has value 00C8 which is 200 in decimal, 
NOP
NOP
STD R2,R5                  #M[15] = 00FC  
NOP
INC R2,R1                 #R2 = 0002, C--> 0, N --> 0, Z --> 0
LDD R0, R1                      #R0 = M[1] = 000F //R0 is the destination, R1 is the address (opposite to STD)
LDD R7, R3                      #R7 = M[200] = 001F
AND R1,R2,R6        #R1 = 0, C--> 0, N --> 0, Z --> 1
INC R1,R1                 #R1 = 0001, C--> 0, N --> 0, Z --> 0
NOP                        #Flags no change
AND R5,R3,R4        #R5 = 0008, C--> 0, N --> 0, Z --> 0
NOP                        #Flags no change, C--> 0, N --> 0, Z --> 0
NOP					# this instruction should be at address 106h


.org 30
NOT  R4,R5						# this instruction should be at address 30H 
 
