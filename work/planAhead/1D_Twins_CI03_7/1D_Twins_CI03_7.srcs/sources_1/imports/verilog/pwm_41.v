/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     WIDTH = 8
     TOP = 62
     DIV = 11
*/
module pwm_41 (
    input clk,
    input rst,
    input [7:0] value,
    input update,
    output reg pulse
  );
  
  localparam WIDTH = 4'h8;
  localparam TOP = 6'h3e;
  localparam DIV = 4'hb;
  
  
  wire [8-1:0] M_ctr_value;
  counter_47 ctr (
    .clk(clk),
    .rst(rst),
    .value(M_ctr_value)
  );
  reg [7:0] M_curValue_d, M_curValue_q = 1'h0;
  reg M_needUpdate_d, M_needUpdate_q = 1'h0;
  reg [7:0] M_nextValue_d, M_nextValue_q = 1'h0;
  
  always @* begin
    M_needUpdate_d = M_needUpdate_q;
    M_nextValue_d = M_nextValue_q;
    M_curValue_d = M_curValue_q;
    
    if (!(|M_ctr_value) && M_needUpdate_q) begin
      M_curValue_d = M_nextValue_q;
      M_needUpdate_d = 1'h0;
    end
    if (update) begin
      M_nextValue_d = value;
      M_needUpdate_d = 1'h1;
    end
    pulse = M_ctr_value < M_curValue_q;
  end
  
  always @(posedge clk) begin
    M_nextValue_q <= M_nextValue_d;
    
    if (rst == 1'b1) begin
      M_curValue_q <= 1'h0;
      M_needUpdate_q <= 1'h0;
    end else begin
      M_curValue_q <= M_curValue_d;
      M_needUpdate_q <= M_needUpdate_d;
    end
  end
  
endmodule
