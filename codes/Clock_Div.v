module Clock_Div (clk_in, clk_sw_1, clk_sw_2, clk_out);
 
  input clk_in;
  input clk_sw_1;
  input clk_sw_2;
  output clk_out;
    
  // Constants (parameters) to create the frequencies needed:
  // Input clock is 50 MHZ
  // Formula is: (50 MHz / ? Hz * 50% duty cycle)
  // So for 4 Hz: 50,000,000 / 4 * 0.5 = 6250000
  parameter fre_4HZ = 6250000;
  parameter fre_2HZ = 12500000;
  parameter fre_1HZ = 25000000;
 
  // These signals will be the counters:
  reg [31:0] counter_4HZ = 0;
  reg [31:0] counter_2HZ = 0;
  reg [31:0] counter_1HZ = 0;
   
  // These signals will toggle at the frequencies needed:
  reg clk_toggle_4HZ = 1'b0;
  reg clk_toggle_2HZ = 1'b0;
  reg clk_toggle_1HZ = 1'b0;
   
  // One bit select
  reg clk_select;
 
  // All always blocks toggle a specific signal at a different frequency.
  // They all run continuously even if the switches are
  // not selecting their particular output.
 
  always @ (posedge clk_in)
    begin
      if (counter_4HZ == fre_4HZ-1) // -1, since counter starts at 0
        begin        
          clk_toggle_4HZ <= !clk_toggle_4HZ;
          counter_4HZ <= 0;
        end
      else
        counter_4HZ <= counter_4HZ + 1;
    end
 
   
  always @ (posedge clk_in)
    begin
      if (counter_2HZ == fre_2HZ-1) // -1, since counter starts at 0
        begin        
          clk_toggle_2HZ <= !clk_toggle_2HZ;
          counter_2HZ <= 0;
        end
      else
        counter_2HZ <= counter_2HZ + 1;
    end
 
 
  always @ (posedge clk_in)
    begin
      if (counter_1HZ == fre_1HZ-1) // -1, since counter starts at 0
        begin        
          clk_toggle_1HZ <= !clk_toggle_1HZ;
          counter_1HZ <= 0;
        end
      else
        counter_1HZ <= counter_1HZ + 1;
    end
 
  // Create a multiplexer based on switch inputs
  always @ (*)
  begin
    case ({clk_sw_1, clk_sw_2})
      2'b11 : clk_select <= clk_toggle_4HZ; // If sw_1 = 1 and sw_2 = 1 -> Use 4 HZ frequency
      2'b10 : clk_select <= clk_toggle_2HZ; // If sw_1 = 1 and sw_2 = 0 -> Use 2 HZ frequency
      2'b01 : clk_select <= clk_toggle_1HZ; // If sw_1 = 0 and sw_2 = 1 -> Use 1 HZ frequency
      2'b00 : clk_select <= clk_in; // Use 50 MHZ frequency
    endcase     
  end
 
  assign clk_out = clk_select;
   
endmodule
