module Datapath_Unit(Led, mode, clk, en, rst, LR, switch_r1r2, auto_rst);

	input [1:0] mode;
	input	clk, en, rst, LR, switch_r1r2, auto_rst;
	output reg [26:0] Led; // LEDR and LEDG together
	
	always @(posedge clk) begin
	
	
		if (mode == 2'b01) begin // "REPEAT RULE 1"
			
			if (rst == 1)
				Led <= 27'h07;
				
			else if (en == 1) begin
			
				if (LR == 0)
					Led <= {Led[23:0], 3'b0}; // 3 LEDs run to the left
				else
					Led <= {3'b0, Led[26:3]}; // 3 LEDs run to the right
			
			end
			
		end
		
		
		else if (mode == 2'b10) begin // "REPEAT RULE 2"
			
			if (rst == 1)
				Led <= 27'b100000000000000000000000001;
				//Led[26] <= 1;
				//Led[0] <= 1;
			
			else if (en == 1) begin
			
				if (LR == 0) begin
					Led[12:0] <= {Led[11:0], 1'b1}; // turn on each LED from the right
					Led[26:13] <= {1'b1, Led[26:14]}; // turn on each LED from the left
				end
				
				else
					Led <= {1'b0, Led[26:1]}; // turn off LEDs from left to right		
			
			end
			
		end
		
		
		else if (mode == 2'b11) begin // "AUTOMATIC"
			
			if (rst == 1)
				Led <= 27'h07;
			
			else if (auto_rst == 1) begin
				if (LR == 0)
					Led <= 27'b100000000000000000000000001; 
				else if (LR == 1)
					Led[2:0] <= 3'b111;
			end
			
			else if (en == 1) begin
			
				if (LR == 0 && switch_r1r2 == 0)
					Led <= {Led[23:0], 3'b0}; // 3 LEDs run to the left
					
				else if (LR == 1 && switch_r1r2 == 0)
					Led <= {3'b0, Led[26:3]}; // 3 LEDs run to the right

				else if (LR == 0 && switch_r1r2 == 1) begin
					Led[12:0] <= {Led[11:0], 1'b1}; // turn on each LED from the right
					Led[26:13] <= {1'b1, Led[26:14]}; // turn on each LED from the left
				end
				
				else if (LR == 1 && switch_r1r2 == 1)
					Led <= {1'b0, Led[26:1]}; // turn off LEDs from left to right	
			
			end
		
		end
		
		
		else
			Led = 27'h0;
			
		
	end
	
endmodule
