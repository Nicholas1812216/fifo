`timescale 1ns / 1ps


module top_wrapper(
  input clk_ref,
  input rd_clk
    );

localparam WIDTH = 10;
localparam DEPTH = 32;
logic rst;
logic wr_clk;
logic wr;
logic rd;
logic [WIDTH - 1 : 0] data_in;
logic [WIDTH - 1 : 0] data_out;

logic empty;
logic full;
  clk_wiz_0 mmcm
   (
    // Clock out ports
    .clk_out1(wr_clk),     // output clk_out1
   // Clock in ports
    .clk_in1(clk_ref)
); 
    logic rd_clkO;
    
   BUFG BUFG_rdclk_inst (
      .O(rd_clkO), // 1-bit output: Clock output
      .I(rd_clk)  // 1-bit input: Clock input
   );

logic wr_reg, full_reg;
logic [WIDTH - 1 : 0] data_in_reg;
logic rd_reg, rst_reg, empty_reg;
logic [WIDTH - 1 : 0] data_out_reg;

async_fifo_wrapper #(.WIDTH(WIDTH),.SYNCWIDTH(3)) async_fifo_inst(
  .reset(rst_reg),
  //rdclk domain
  .rd(rd_reg),
  .dataout(data_out_reg),
  .rdclk(rd_clkO),
  .empty(empty_reg),

  //wrclk domain
  .wr(wr_reg),
  .wrclk(wr_clk),
  .datain(data_in_reg),
  .full(full_reg)
);


always_ff@(posedge wr_clk) begin
  wr_reg <= wr;
  data_in_reg <= data_in;
  full<= full_reg ;
  rst_reg <= rst;
end

always_ff@(posedge rd_clkO) begin
  rd_reg <= rd;
  data_out <= data_out_reg;
  empty <= empty_reg;
end

vio_0 vio (
  .clk(rd_clkO),                // input wire clk
  .probe_out0(rd),  // output wire [0 : 0] probe_out0
  .probe_out1(),  // output wire [0 : 0] probe_out1
  .probe_out2(),  // output wire [0 : 0] probe_out2
  .probe_out3()  // output wire [31 : 0] probe_out3
);

vio_0 viowr_clk(
  .clk(wr_clk),                // input wire clk
  .probe_out0(rst),  // output wire [0 : 0] probe_out0
  .probe_out1(wr),  // output wire [0 : 0] probe_out1
  .probe_out2(),  // output wire [0 : 0] probe_out2
  .probe_out3(data_in)  // output wire [31 : 0] probe_out3
);
    

ila_0 ila_rd (
	.clk(rd_clkO), // input wire clk
	.probe0(empty), // input wire [0:0]  probe0  
	.probe1('0), // input wire [0:0]  probe1 
	.probe2(data_out) // input wire [31:0]  probe2
);
   
ila_0 ila_wr (
	.clk(wr_clk), // input wire clk
	.probe0(full), // input wire [0:0]  probe0  
	.probe1('0), // input wire [0:0]  probe1 
	.probe2('0) // input wire [31:0]  probe2
);   
    
endmodule
