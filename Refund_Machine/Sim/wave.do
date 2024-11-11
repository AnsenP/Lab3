onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_refund_machine/sys_clk
add wave -noupdate /tb_refund_machine/sys_rst_n
add wave -noupdate /tb_refund_machine/pi_money_one
add wave -noupdate /tb_refund_machine/pi_money_half
add wave -noupdate /tb_refund_machine/random_data_gen
add wave -noupdate /tb_refund_machine/po_beverage
add wave -noupdate /tb_refund_machine/po_money_one
add wave -noupdate /tb_refund_machine/po_money_half
add wave -noupdate /tb_refund_machine/state
add wave -noupdate /tb_refund_machine/pi_money
add wave -noupdate /tb_refund_machine/po_money
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {512 ns}
