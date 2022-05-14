module Control_Unit(auto_rst, switch_r1r2, LR, en_DP, mode, clk, rst, en, feedback);

	output en_DP;
	output reg LR;
	output reg auto_rst;
	output reg switch_r1r2;	// switch rules in AUTOMATIC mode
	input en, rst, clk;
	input [1:0] mode;
	input [26:0] feedback;
	
	assign en_DP = en;
	
	always @(posedge clk) begin
	
	
		if (mode == 2'b01) begin // "REPEAT RULE 1"
			
			if (rst == 1)
				LR <= 0;
				
			else begin
				if (feedback == 27'h38) // control navigation at the right edge
					LR <= 0;
				if (feedback == 27'b111000000000000000000000) // control navigation at the left edge
					LR <= 1;
			end
				
		end
		
		
		else if (mode == 2'b10) begin // "REPEAT RULE 2"
			
			if (rst == 1)
				LR <= 0;
			
			else begin
				if (feedback[14] == 1) // to turn off LEDs (when LEDs run to middle)
					LR <= 1;
				if (feedback[1] == 0) // to turn on from both edges (when the last LED is off)
					LR <= 0;	
			end
				
		end
		
		
		else if (mode == 2'b11) begin // "AUTOMATIC"
			
			if (rst == 1) begin
				LR <= 0;
				switch_r1r2 <= 0;
				auto_rst <= 0;
			end
				
			else begin
			
				if (feedback == 27'b111000000000000000000000) // control navigation at the left edge
					LR <= 1;
					
				else if (feedback == 27'h38) begin // control navigation at the right edge
					LR <= 0; 
					if (LR == 1)
						auto_rst <= 1;
				end
				
				else if (feedback == 27'b100000000000000000000000001) begin
					if (LR == 0) begin
						switch_r1r2 <= 1;
						auto_rst <= 0;
					end
				end		
					
				else if (feedback[14] == 1) // to turn off LEDs (when LEDs run to middle)
					if (switch_r1r2 == 1) 
						LR <= 1;
					
				else if (feedback[1] == 0) // to turn on from both edges (when the last LED is off)
					if (LR == 1 && switch_r1r2 == 1) 
						auto_rst <= 1;
				
				
				else if (feedback[0] == 0) begin
					if (LR == 1 && switch_r1r2 == 1) begin
						LR <= 0;
						switch_r1r2 <= 0;
						auto_rst <= 0;
					end
				end
								
			end
				
		end
		
		
		else
			LR <= 0;
			
		
	end

endmodule
