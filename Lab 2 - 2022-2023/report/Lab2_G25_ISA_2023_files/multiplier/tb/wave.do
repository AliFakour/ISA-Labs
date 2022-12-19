onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mul/clk_i
add wave -noupdate /tb_mul/rst_ni
add wave -noupdate -divider <NULL>
add wave -noupdate -radix decimal /tb_mul/UUT/x
add wave -noupdate -radix decimal /tb_mul/UUT/y
add wave -noupdate -divider <NULL>
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/x
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/y
add wave -noupdate -divider <NULL>
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/_nx
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/_2x
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/_n2x
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/_3x
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/_n3x
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/_4x
add wave -noupdate -radix decimal /tb_mul/UUT/partial_products/_n4x
add wave -noupdate -divider <NULL>
add wave -noupdate -radix binary /tb_mul/UUT/partial_products/yExt
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[0]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[0]/BE/sel}
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[1]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[1]/BE/sel}
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[2]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[2]/BE/sel}
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[3]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[3]/BE/sel}
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[4]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[4]/BE/sel}
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[5]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[5]/BE/sel}
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[6]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[6]/BE/sel}
add wave -noupdate -color gold -radix binary {/tb_mul/UUT/partial_products/BE_i[7]/BE/dIn}
add wave -noupdate {/tb_mul/UUT/partial_products/BE_i[7]/BE/sel}
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_mul/UUT/partial_products/not_msb_pp
add wave -noupdate -color gold -radix decimal -radixshowbase 0 /tb_mul/UUT/partial_products/partial_p
add wave -noupdate -radix decimal -childformat {{{/tb_mul/UUT/partial_products/PP[0]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[1]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[2]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[3]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[4]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[5]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[6]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[7]} -radix decimal} {{/tb_mul/UUT/partial_products/PP[8]} -radix decimal}} -subitemconfig {{/tb_mul/UUT/partial_products/PP[0]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[1]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[2]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[3]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[4]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[5]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[6]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[7]} {-height 17 -radix decimal} {/tb_mul/UUT/partial_products/PP[8]} {-height 17 -radix decimal}} /tb_mul/UUT/partial_products/PP
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50529 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 213
configure wave -valuecolwidth 100
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {105 us}
