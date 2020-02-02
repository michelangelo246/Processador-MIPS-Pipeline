onerror {quit -f}
vlib work
vlog -work work MIPS.vo
vlog -work work MIPS.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.MIPS_vlg_vec_tst
vcd file -direction MIPS.msim.vcd
vcd add -internal MIPS_vlg_vec_tst/*
vcd add -internal MIPS_vlg_vec_tst/i1/*
add wave /*
run -all
