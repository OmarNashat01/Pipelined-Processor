restart -all
vsim -gui work.CPU
mem load -i {D:/Senior 1 (Spring)/Computer Architecture/Project/Pipelined-Processor/project_files/instruction_cache.mem} /cpu/icInst/ram
add wave -position insertpoint sim:/cpu/*
force -freeze sim:/cpu/clock 1 0, 0 {50 ps} -r 100
force -freeze sim:/cpu/reset 1 0
run
force -freeze sim:/cpu/reset 0 1
force -freeze sim:/cpu/inPort FFFE 0
run
run
run
run
run
run
run
run
run
force -freeze sim:/cpu/inPort 0001 0
run
force -freeze sim:/cpu/inPort 000F 0
run
force -freeze sim:/cpu/inPort 00C8 0
run
force -freeze sim:/cpu/inPort 001F 0
run
force -freeze sim:/cpu/inPort 00FC 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


