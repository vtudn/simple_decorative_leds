module Led7_Decoder(clk, clk_sw_1, clk_sw_2, mode, hex0, hex1); // anode

	output [6:0] hex0; // display MODE: 1 (REPEAT RULE 1) or 2 (REPEAT RULE 2) or 3 (AUTOMATIC) or 0 (NO MODE)
	output [6:0] hex1; // display SPEED: 1 (1HZ) or 2 (2HZ) or 4 (4HZ) or 0 (50MHZ)
	input [1:0] mode;
	input clk, clk_sw_1, clk_sw_2;
	
	reg [6:0] hex0_reg;
	reg [6:0] hex1_reg;

	always @ (posedge clk) begin
	
		if (mode == 2'b01) // MODE 1
			hex0_reg <= 7'b0110000;
	
		if (mode == 2'b10) // MODE 2
			hex0_reg <= 7'b1101101;
	
		if (mode == 2'b11) // MODE 3
			hex0_reg <= 7'b1111001;
	
		if (mode == 2'b00) // NO MODE
			hex0_reg <= 7'b1111110;
	
		if (clk_sw_1 == 0 && clk_sw_2 == 1) // 1 HZ
			hex1_reg <= 7'b0110000;

		if (clk_sw_1 == 1 && clk_sw_2 == 0) // 2 HZ
			hex1_reg <= 7'b1101101;
	
		if (clk_sw_1 == 1 && clk_sw_2 == 1) // 4 HZ
			hex1_reg <= 7'b0110011;
	
		if (clk_sw_1 == 0 && clk_sw_2 == 0) // 50 MHZ
			hex1_reg <= 7'b1111110;
	
	end
	
	assign hex0 = hex0_reg;
	assign hex1 = hex1_reg;
	
endmodule
