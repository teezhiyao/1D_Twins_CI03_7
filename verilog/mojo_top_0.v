/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    input cclk,
    output reg spi_miso,
    output reg [7:0] led,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output reg [3:0] spi_channel,
    input avr_tx,
    output reg avr_rx,
    input avr_rx_busy,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  wire [16-1:0] M_alu_alu;
  wire [3-1:0] M_alu_zvn;
  reg [6-1:0] M_alu_alufn;
  reg [16-1:0] M_alu_a;
  reg [16-1:0] M_alu_b;
  alu_1 alu (
    .alufn(M_alu_alufn),
    .a(M_alu_a),
    .b(M_alu_b),
    .alu(M_alu_alu),
    .zvn(M_alu_zvn)
  );
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_2 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  wire [1-1:0] M_button_condd_out;
  reg [1-1:0] M_button_condd_in;
  button_conditioner_3 button_condd (
    .clk(clk),
    .in(M_button_condd_in),
    .out(M_button_condd_out)
  );
  wire [1-1:0] M_edge_out;
  reg [1-1:0] M_edge_in;
  edge_detector_4 L_edge (
    .clk(clk),
    .in(M_edge_in),
    .out(M_edge_out)
  );
  wire [8-1:0] M_seg_display_seg;
  wire [4-1:0] M_seg_display_sel;
  reg [16-1:0] M_seg_display_values;
  reg [4-1:0] M_seg_display_decimal;
  multi_seven_seg_5 seg_display (
    .clk(clk),
    .rst(rst),
    .values(M_seg_display_values),
    .decimal(M_seg_display_decimal),
    .seg(M_seg_display_seg),
    .sel(M_seg_display_sel)
  );
  localparam ALUFN_state = 3'd0;
  localparam INPUT_A_state = 3'd1;
  localparam INPUT_B_state = 3'd2;
  localparam AUTO_state = 3'd3;
  localparam DISPLAY_state = 3'd4;
  
  reg [2:0] M_state_d, M_state_q = ALUFN_state;
  reg [15:0] M_display_value_d, M_display_value_q = 1'h0;
  reg [4:0] M_mode_d, M_mode_q = 1'h0;
  reg [5:0] M_alufn_st_d, M_alufn_st_q = 1'h0;
  reg [15:0] M_input_a_st_d, M_input_a_st_q = 1'h0;
  reg [15:0] M_input_b_st_d, M_input_b_st_q = 1'h0;
  reg [0:0] M_send_d, M_send_q = 1'h0;
  reg [7:0] M_check_input_d, M_check_input_q = 1'h0;
  
  wire [16-1:0] M_digits_digits;
  reg [14-1:0] M_digits_value;
  bin_to_dec_6 digits (
    .value(M_digits_value),
    .digits(M_digits_digits)
  );
  
  always @* begin
    M_state_d = M_state_q;
    M_alufn_st_d = M_alufn_st_q;
    M_input_b_st_d = M_input_b_st_q;
    M_display_value_d = M_display_value_q;
    M_send_d = M_send_q;
    M_input_a_st_d = M_input_a_st_q;
    M_check_input_d = M_check_input_q;
    M_mode_d = M_mode_q;
    
    io_led = io_dip;
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    M_button_condd_in = io_button[3+0-:1];
    M_edge_in = M_button_condd_out;
    M_send_d = M_edge_out;
    M_seg_display_decimal = 4'h0;
    io_seg = ~M_seg_display_seg;
    io_sel = ~M_seg_display_sel;
    M_alu_alufn = M_alufn_st_q;
    M_alu_a = M_input_a_st_q;
    M_alu_b = M_input_b_st_q;
    M_digits_value = 1'h0;
    led = M_check_input_q;
    
    case (M_state_q)
      ALUFN_state: begin
        M_mode_d = 1'h0;
        if (M_send_q) begin
          M_state_d = INPUT_A_state;
          M_alufn_st_d = io_dip[0+5-:6];
          M_check_input_d[7+0-:1] = 1'h1;
        end else begin
          M_display_value_d = 16'hbcd9;
        end
      end
      INPUT_A_state: begin
        M_mode_d = 1'h1;
        if (M_send_q) begin
          M_state_d = INPUT_B_state;
          M_input_a_st_d = io_dip[0+15-:16];
          M_check_input_d[6+0-:1] = 1'h1;
        end else begin
          M_display_value_d = 16'hb999;
        end
      end
      INPUT_B_state: begin
        M_mode_d = 2'h3;
        if (M_send_q) begin
          M_state_d = DISPLAY_state;
          M_input_b_st_d = io_dip[0+15-:16];
          M_check_input_d[5+0-:1] = 1'h1;
        end else begin
          M_display_value_d = 16'he999;
        end
      end
      DISPLAY_state: begin
        M_mode_d = 3'h4;
        M_check_input_d[0+2-:3] = M_alu_zvn[2+0-:1] + M_alu_zvn[1+0-:1] + M_alu_zvn[0+0-:1];
        if (io_dip[23+0-:1]) begin
          io_led = M_alufn_st_q;
        end else begin
          if (io_dip[22+0-:1]) begin
            io_led = M_input_a_st_q;
          end else begin
            if (io_dip[21+0-:1]) begin
              io_led = M_input_b_st_q;
            end else begin
              M_digits_value = M_alu_alu;
              M_display_value_d = M_digits_digits;
            end
          end
        end
      end
      AUTO_state: begin
        M_mode_d = 3'h5;
      end
    endcase
    M_seg_display_values = M_display_value_q;
  end
  
  always @(posedge clk) begin
    M_display_value_q <= M_display_value_d;
    M_mode_q <= M_mode_d;
    M_alufn_st_q <= M_alufn_st_d;
    M_input_a_st_q <= M_input_a_st_d;
    M_input_b_st_q <= M_input_b_st_d;
    M_send_q <= M_send_d;
    M_check_input_q <= M_check_input_d;
    
    if (rst == 1'b1) begin
      M_state_q <= 1'h0;
    end else begin
      M_state_q <= M_state_d;
    end
  end
  
endmodule
