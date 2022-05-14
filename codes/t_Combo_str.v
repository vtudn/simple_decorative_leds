module t_Combo_str();

	reg clk_50, en, rst, sw_1, sw_2, sw_3, sw_4;
	wire [26:0] led;
	wire [6:0] hex0;
	wire [6:0] hex1;
	parameter timeout = 800;
	
	initial #timeout $finish;
	
	Combo_str C(clk_50, en, rst, sw_1, sw_2, sw_3, sw_4, led, hex0, hex1);
	
	always #5 clk_50 = ~clk_50;

	initial begin
		clk_50 = 0;
		en = 0;
		rst = 0;
		sw_1 = 0;
		sw_2 = 0;
		sw_3 = 0;
		sw_4 = 1;
		
		#20
		rst = 1;
		
		#10
		rst = 0;
		
		#5
		en = 1;
		
		/* #200
		rst = 1;
		
		#10
		sw_3 = 0;
		sw_4 = 1;
		
		#20
		rst = 0; */

	end

endmodule
