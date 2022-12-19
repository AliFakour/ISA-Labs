if [file exists work] { vdel -all -lib work }
vlib work

vlog -work work ../src/package/globals.svh

vlog -work work ../src/compressors/cmpr_4_2.sv
vlog -work work ../src/compressors/fa.sv
vlog -work work ../src/compressors/ha.sv

vlog -work work ../src/PPG/booth_encoder/booth_encoder.sv

vlog -work work ../src/PPG/PPG.sv

vlog -work work ../src/dadda\ tree/daddaTree.sv

vlog -work work ../src/multiplier.sv

vcom -work work ../tb/clk_gen.vhd
vcom -work work ../tb/data_gen.vhd

vlog -reportprogress 300 -work work {/home/isa11_2022_2023/Desktop/Lab2/R8-MBE multiplier/tb/tb_mul.sv}

vsim -work work work.tb_mul -voptargs=+acc

source wave.do

run 100 us
