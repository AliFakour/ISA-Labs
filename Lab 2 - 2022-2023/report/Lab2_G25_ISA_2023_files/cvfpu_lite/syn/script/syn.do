remove_design -designs

analyze -f sverilog -lib WORK ../src/cf_math_pkg.sv
analyze -f sverilog -lib WORK ../src/lzc.sv
analyze -f sverilog -lib WORK ../src/rr_arb_tree.sv
analyze -f sverilog -lib WORK ../src/fpnew_pkg.sv
analyze -f sverilog -lib WORK ../src/fpnew_classifier.sv
analyze -f sverilog -lib WORK ../src/fpnew_rounding.sv
analyze -f sverilog -lib WORK ../src/fpnew_fma.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_fmt_slice.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_block.sv
analyze -f sverilog -lib WORK ../src/fpnew_top.sv

set power_preserve_rtl_hier_names true

elaborate fpnew_top -lib WORK
link

create_clock -name CLK -period 0 clk_i
set_dont_touch_network CLK
set_clock_uncertainty 0.07 [get_clocks CLK]
set_input_delay 0.5 -max -clock CLK [remove_from_collection [all_inputs] clk_i]
set_output_delay 0.5 -max -clock CLK [all_outputs ]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

# (1) - compile the model
compile
report_timing >> reports/1_report_timing_maxFreq.txt
report_area	>> reports/1_report_area_maxFreq.txt

# (2) - optimize the registers
optimize_registers
report_timing >> reports/2_report_timing_maxFreq_regOptim.txt
report_area	>> reports/2_report_area_maxFreq_regOptim.txt

remove_design -all

analyze -f sverilog -lib WORK ../src/cf_math_pkg.sv
analyze -f sverilog -lib WORK ../src/lzc.sv
analyze -f sverilog -lib WORK ../src/rr_arb_tree.sv
analyze -f sverilog -lib WORK ../src/fpnew_pkg.sv
analyze -f sverilog -lib WORK ../src/fpnew_classifier.sv
analyze -f sverilog -lib WORK ../src/fpnew_rounding.sv
analyze -f sverilog -lib WORK ../src/fpnew_fma.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_fmt_slice.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_block.sv
analyzeremove_design -designs -f sverilog -lib WORK ../src/fpnew_top.sv

set power_preserve_rtl_hier_names true

elaborate fpnew_top -lib WORK
link

create_clock -name CLK -period 0 clk_i
set_dont_touch_network CLK
set_clock_uncertainty 0.07 [get_clocks CLK]
set_input_delay 0.5 -max -clock CLK [remove_from_collection [all_inputs] clk_i]
set_output_delay 0.5 -max -clock CLK [all_outputs ]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

# (3) - compile ultra
compile_ultra
report_timing >> reports/3_report_timing_maxFreq_ultra.txt
report_area	>> reports/3_report_area_maxFreq_ultra.txt

remove_design -all

analyze -f sverilog -lib WORK ../src/cf_math_pkg.sv
analyze -f sverilog -lib WORK ../src/lzc.sv
analyze -f sverilog -lib WORK ../src/rr_arb_tree.sv
analyze -f sverilog -lib WORK ../src/fpnew_pkg.sv
analyze -f sverilog -lib WORK ../src/fpnew_classifier.sv
analyze -f sverilog -lib WORK ../src/fpnew_rounding.sv
analyze -f sverilog -lib WORK ../src/fpnew_fma.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_fmt_slice.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_block.sv
analyzeremove_design -designs -f sverilog -lib WORK ../src/fpnew_top.sv

set power_preserve_rtl_hier_names true

elaborate fpnew_top -lib WORK
link

create_clock -name CLK -period 0 clk_i
set_dont_touch_network CLK
set_clock_uncertainty 0.07 [get_clocks CLK]
set_input_delay 0.5 -max -clock CLK [remove_from_collection [all_inputs] clk_i]
set_output_delay 0.5 -max -clock CLK [all_outputs ]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

# force compiler to hierachy flatting
ungroup -all -flatten
# set CSA for MULT
set_implementation DW02_mult/csa [find cell *mult*]

# (4 - 1) compile flatten
compile
report_timing >> reports/4-1_report_timing_maxFreq_flat.txt
report_area	>> reports/4-1_report_area_maxFreq_flat.txt
report_resources >> reports/4-1_report_resources_maxFreq_flat.txt

# (4 - 2) optimize registers
optimize_registers
report_timing >> reports/4-2_report_timing_maxFreq_regOptim_flat.txt
report_area	>> reports/4-2_report_area_maxFreq_regOptim_flat.txt
report_resources >> reports/4-2_report_resources_maxFreq_regOptim_flat.txt

remove_design -all

analyze -f sverilog -lib WORK ../src/cf_math_pkg.sv
analyze -f sverilog -lib WORK ../src/lzc.sv
analyze -f sverilog -lib WORK ../src/rr_arb_tree.sv
analyze -f sverilog -lib WORK ../src/fpnew_pkg.sv
analyze -f sverilog -lib WORK ../src/fpnew_classifier.sv
analyze -f sverilog -lib WORK ../src/fpnew_rounding.sv
analyze -f sverilog -lib WORK ../src/fpnew_fma.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_fmt_slice.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_block.sv
analyzeremove_design -designs -f sverilog -lib WORK ../src/fpnew_top.sv

set power_preserve_rtl_hier_names true

elaborate fpnew_top -lib WORK
link

create_clock -name CLK -period 0 clk_i
set_dont_touch_network CLK
set_clock_uncertainty 0.07 [get_clocks CLK]
set_input_delay 0.5 -max -clock CLK [remove_from_collection [all_inputs] clk_i]
set_output_delay 0.5 -max -clock CLK [all_outputs ]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

# hierachy flatting
ungroup -all -flatten
# set PPARCH for MULT
set_implementation DW02_mult/pparch [find cell *mult*]

# (5 - 1) compile PPARCH
compile
report_timing >> reports/5-1_report_timing_maxFreq_flat_pparch.txt
report_area	>> reports/5-1_report_area_maxFreq_flat_pparch.txt
report_resources >> reports/5-1_report_resources_maxFreq_flat_pparch.txt

# (5 - 2) optimize registers
optimize_registers
report_timing >> reports/5-2_report_timing_maxFreq_regOptim_flat_pparch.txt
report_area	>> reports/5-2_report_area_maxFreq_regOptim_flat_pparch.txt
report_resources >> reports/5-2_report_resources_maxFreq_regOptim_flat_pparch.txt
