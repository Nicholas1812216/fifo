`timescale 1ps/1ps

module simple_fifo_tb();

localparam WIDTH = 8;
localparam DEPTH = 32;
logic rst =0;
logic clk = 0;
logic wr;
logic rd;
logic [WIDTH - 1 : 0] data_in = '0;
logic [WIDTH - 1 : 0] data_out;
logic empty;
logic full;

logic[WIDTH - 1 : 0] fifo_sw_model[$];
logic[WIDTH - 1 : 0] expected_rd_data;
int count = 0;

always begin
  #5ns clk = ~clk;
end

simple_fifo dut(.*);

initial begin
  wr = 0; 
  rd = 0;
  repeat(5) @(posedge clk);
  rst = 1;
  @(posedge clk);
  rst = 0;
  wait(empty == 1'b1);
  @(posedge clk);
  for(int i = 0; i < DEPTH; i++) begin
    wr = 1;
    data_in = i + 1;
    @(posedge clk);
  end
  wr = 0;
  @(posedge clk);
  for(int i = 0; i < DEPTH; i++) begin
    rd = 1;
    @(posedge clk);
  end
  rd = 0;
  $display("[T=%0t], Finished linear test, starting random testing", $realtime);
  @(posedge clk);
  for(int i = 0; i < 1000; i++) begin
    data_in = $urandom();
    if(i%100 == 0) begin //reset
      wr = 0;
      rd = 0;
      rst = $urandom();
      @(posedge clk);
      rst = 0;
      repeat(4) @(posedge clk);
    end else begin
      wr = $urandom();
      rd = $urandom();
      @(posedge clk);
    end
  end
  wr = 0;
  rd = 0;
  $display("[T=%0t], Finished random testing", $realtime);
end

//self checking
always_ff@(negedge clk) begin
  if(rst) begin
    count <= 0;
    fifo_sw_model.delete();
  end else begin
    if(count < DEPTH && wr == 1'b1) begin
      count <= count + 1;
      fifo_sw_model.push_front(data_in);
    end
    if(count > 0 && rd == 1'b1 && empty == 1'b0) begin
      count <= count - 1;
      expected_rd_data = fifo_sw_model.pop_back();
    end
    if(count < DEPTH && wr == 1'b1 && count > 0 && rd == 1'b1 && empty == 1'b0) begin
        count <= count;
    end
    if(rd == 1'b1 && empty == 1'b0) begin
      assert (data_out == expected_rd_data) else $error("[T=%0t], Data error, actual: %u, expected: %u", $realtime, data_out, expected_rd_data);
    end
  end
end

endmodule