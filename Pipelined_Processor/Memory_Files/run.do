restart -all
vsim -gui work.CPU
mem load -i C:/Users/sicom/Desktop/University/Arch/Project/Pipelined_Processor/Memory_Files/instruction_cache.mem -filltype value -filldata 0 -fillradix symbolic -skip 0 /cpu/icInst/ram
add wave -position insertpoint sim:/cpu/*
force -freeze sim:/cpu/clock 1 0, 0 {50 ps} -r 100
force -freeze sim:/cpu/reset 1 0
run
force -freeze sim:/cpu/reset 0 1
run
