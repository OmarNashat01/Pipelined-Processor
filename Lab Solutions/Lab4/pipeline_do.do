mem load -i {D:/Senior 1 (Spring)/Computer Architecture/Lab Solutions/Lab4/cache.mem} /pipeline/IC1/ram
mem load -i {D:/Senior 1 (Spring)/Computer Architecture/Lab Solutions/Lab4/registers.mem} /pipeline/RF1/R1/ram
force -freeze sim:/pipeline/Clk 0 0, 1 {5000 ps} -r 10ns
force -freeze sim:/pipeline/En 1 0
force -freeze sim:/pipeline/Rst 1 0
run
force -freeze sim:/pipeline/Rst 0 0
run
