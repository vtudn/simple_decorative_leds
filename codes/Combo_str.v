module Combo_str(clk_50, en, rst, sw_1, sw_2, sw_3, sw_4, led, hex0, hex1);

	input clk_50, en, rst, sw_1, sw_2, sw_3, sw_4;
	output [26:0] led;
	output [6:0] hex0;
	output [6:0] hex1;
	wire [1:0] mode;
	wire clk_new, auto_rst, switch_r1r2, LR, en_DP;
	
Clock_Div A(clk_50, sw_1, sw_2, clk_new);

Mode_Select M(clk_new, sw_3, sw_4, mode);

Led7_Decoder L(clk_new, sw_1, sw_2, mode, hex0, hex1);

Control_Unit C(auto_rst, switch_r1r2, LR, en_DP, mode, clk_new, rst, en, led);

Datapath_Unit D(led, mode, clk_new, en_DP, rst, LR, switch_r1r2, auto_rst);

endmodule
