onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/clk_i
add wave -noupdate -color red -radix float32 -radixshowbase 0 /tb_fpnew_top/UUT/rst_ni
add wave -noupdate -color Orange -radix float32 -childformat {{{/tb_fpnew_top/UUT/operands_i[2]} -radix float32} {{/tb_fpnew_top/UUT/operands_i[1]} -radix float32} {{/tb_fpnew_top/UUT/operands_i[0]} -radix float32}} -radixshowbase 0 -expand -subitemconfig {{/tb_fpnew_top/UUT/operands_i[2]} {-color Orange -height 17 -radix float32 -radixshowbase 0} {/tb_fpnew_top/UUT/operands_i[1]} {-color Orange -height 17 -radix float32 -radixshowbase 0} {/tb_fpnew_top/UUT/operands_i[0]} {-color Orange -height 17 -radix float32 -radixshowbase 0}} /tb_fpnew_top/UUT/operands_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/rnd_mode_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/op_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/op_mod_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/src_fmt_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/dst_fmt_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/int_fmt_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/vectorial_op_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/tag_i
add wave -noupdate -color Plum -radix float32 -radixshowbase 0 /tb_fpnew_top/UUT/in_valid_i
add wave -noupdate -color Plum -radix float32 -radixshowbase 0 /tb_fpnew_top/UUT/in_ready_o
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/flush_i
add wave -noupdate -color orange -radix float32 -radixshowbase 0 /tb_fpnew_top/UUT/result_o
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/status_o
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/tag_o
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/out_valid_o
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/out_ready_i
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/busy_o
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/opgrp_in_ready
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/opgrp_out_valid
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/opgrp_out_ready
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/opgrp_ext
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/opgrp_busy
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/opgrp_outputs
add wave -noupdate -radix float32 /tb_fpnew_top/UUT/is_boxed
add wave -noupdate -color gold -radix float32 -childformat {{/tb_fpnew_top/UUT/arbiter_output.result -radix float32} {/tb_fpnew_top/UUT/arbiter_output.status -radix float32} {/tb_fpnew_top/UUT/arbiter_output.tag -radix float32}} -radixshowbase 0 -expand -subitemconfig {/tb_fpnew_top/UUT/arbiter_output.result {-color gold -height 17 -radix float32} /tb_fpnew_top/UUT/arbiter_output.status {-color gold -height 17 -radix float32} /tb_fpnew_top/UUT/arbiter_output.tag {-color gold -height 17 -radix float32}} /tb_fpnew_top/UUT/arbiter_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {78890 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
configure wave -valuecolwidth 128
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {162750 ps}
