`timescale 1ps/1ps

module async_tb();
  localparam WIDTH = 18;
  logic reset;
  //rdclk domain
  logic rd = 0;
  logic [WIDTH - 1 : 0] dataout;
  logic rdclk = 0;
  logic empty;

  //wrclk domain
  logic wr = 0;
  logic wrclk = 0;
  logic [$size(dataout) - 1 : 0] datain;
  logic full;

always begin
  #5ns wrclk = ~wrclk;
end

always begin
  #3.33ns rdclk = ~rdclk;
end

async_fifo_top #(.WIDTH(WIDTH)) dut(.*);

  initial begin
    reset = 1'b1;
    repeat(3) @(posedge wrclk);
    reset = 1'b0;
    wait(full == 1'b0);
    @(posedge wrclk);
    wr = 1;
    wait(full == 1'b1);
    wr = 0;
    repeat(3) @(posedge wrclk);
    @(posedge rdclk); 
    rd = 1;
    wait(empty == 1'b1);
    rd = 0;
  end

endmodule