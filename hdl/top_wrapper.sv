`timescale 1ns / 1ps


module top_wrapper(
  input clk_ref
    );

localparam WIDTH = 10;
localparam DEPTH = 32;
logic rst;
logic clk;
logic wr;
logic rd;
logic [WIDTH - 1 : 0] data_in;
logic [WIDTH - 1 : 0] data_out;

logic empty;
logic full;
  clk_wiz_0 mmcm
   (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
   // Clock in ports
    .clk_in1(clk_ref)
); 
    
    
//vio_0 vio (
//  .clk(clk),                // input wire clk
//  .probe_out0(rst),  // output wire [0 : 0] probe_out0
//  .probe_out1(wr),  // output wire [0 : 0] probe_out1
//  .probe_out2(rd),  // output wire [0 : 0] probe_out2
//  .probe_out3(data_in)  // output wire [31 : 0] probe_out3
//);


//ila_0 ila (
//	.clk(clk), // input wire clk
//	.probe0(full), // input wire [0:0]  probe0  
//	.probe1(empty), // input wire [0:0]  probe1 
//	.probe2(data_out) // input wire [31:0]  probe2
//);
    
    
//simple_fifo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifo_test(
//           .rst(rst),
//           .clk(clk),
//           .wr(wr),
//           .rd(rd),
//           .data_in (data_in),
//           .data_out(data_out),
//           .empty(empty),
//           .full(full)
//         );    




logic [WIDTH - 1 : 0] doa, dob, dia, dib;
logic [11:0] aa, ab;

dualPortRAM#(.WIDTH(WIDTH)) ram_test( //only 8-36 supported

      .DOA(doa),       // Output port-A data, width defined by READ_WIDTH_A parameter
      .DOB(),       // Output port-B data, width defined by READ_WIDTH_B parameter
      .ADDRA(aa),   // based on max depth defined in table below
      .ADDRB(aa),   // based on max depth defined in table below
      .CLKA(clk),     // 1-bit input port-A clock
      .CLKB(clk),     // 1-bit input port-B clock
      .DIA('0),       // Input port-A data, width defined by WRITE_WIDTH_A parameter
      .DIB(dib),       // Input port-B data, width defined by WRITE_WIDTH_B parameter
      .RSTA(1'b0),     // 1-bit input port-A reset
      .RSTB(1'b0),     // 1-bit input port-B reset
      .WEA('0),       // Input port-A write enable, width defined by Port A depth
      .WEB('1)        // Input port-B write enable, width defined by Port B depth
);


vio_0 vio (
  .clk(clk),                // input wire clk
  .probe_out0(),  // output wire [0 : 0] probe_out0
  .probe_out1(),  // output wire [0 : 0] probe_out1
  .probe_out2(),  // output wire [0 : 0] probe_out2
  .probe_out3(aa)  // output wire [31 : 0] probe_out3
);

vio_0 vioData (
  .clk(clk),                // input wire clk
  .probe_out0(),  // output wire [0 : 0] probe_out0
  .probe_out1(),  // output wire [0 : 0] probe_out1
  .probe_out2(),  // output wire [0 : 0] probe_out2
  .probe_out3(dib)  // output wire [31 : 0] probe_out3
);
    

ila_0 ila (
	.clk(clk), // input wire clk
	.probe0('0), // input wire [0:0]  probe0  
	.probe1('0), // input wire [0:0]  probe1 
	.probe2(doa) // input wire [31:0]  probe2
);
    
endmodule
