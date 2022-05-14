module Mode_Select(clk, mode_sw_3, mode_sw_4, mode_out);
	
	input clk;
	input mode_sw_3;
	input mode_sw_4;
	output [1:0] mode_out;
	
	reg [1:0] mode_select;
	
	always @ (posedge clk)
	begin
    case ({mode_sw_3, mode_sw_4})
      2'b01 : mode_select <= 2'b01; // If sw_3 = 0 and sw_4 = 1 -> Use mode "REPEAT RULE 1"
      2'b10 : mode_select <= 2'b10; // If sw_3 = 1 and sw_4 = 0 -> Use mode "REPEAT RULE 2"
      2'b11 : mode_select <= 2'b11; // If sw_3 = 1 and sw_4 = 1 -> Use mode "AUTOMATIC"
      2'b00 : mode_select <= 2'b00; // Nothing happens
    endcase     
	end
 
  assign mode_out = mode_select;
  
endmodule
