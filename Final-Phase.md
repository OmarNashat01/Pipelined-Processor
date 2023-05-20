# Forwarding Unit: Alu Mux

## inputs: 

> Rdst here is (Rdst Ex, Rdst Mem1, Rdst Mem2)
> Rdst == Rsrc1 or Rdst == Rsrc2 first enable<br>
> RegWrite is like second Enable

- Decode Buffer: Rsrc1, Rsrc2
- Execute Buffer: Rdst, RdstVal, RegWrite
- Memory-1 Buffer: Rdst, RdstVal, MemRead, RegWrite
- Memory-2 Buffer: Rdst, RdstVal, RegWrite


## outputs:

- Selector for ALU MUX
- Data for ALU MUX


# Hazard Detection Unit:

- How to stall?
- when to stall



# PC:

- Handle PC changes




## Handle Reset:
> reset pc to value in memory


## Handle interrupt


# MUX for delw2ty ehna 2altly abl el mem buffer kona 3amlyn mux wahed by2ol hakhod el haga mel excute la2 makonash 3amlyn wel data kharga mel ex w  mel alu el pc wel flags w sa3etha el adress hyb2a sp wala sp1