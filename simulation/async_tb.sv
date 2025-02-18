`timescale 1ps/1ps

module async_tb();
  localparam WIDTH = 36;
  localparam DEPTH = 1024;
  localparam ASIZE = 10;
  logic reset, rd_rst_n;
  //rdclk domain
  logic rd = 0;
  logic [WIDTH - 1 : 0] dataout, datao_chk;
  logic rdclk = 0;
  logic empty, empty_chk;

  //wrclk domain
  logic wr = 0;
  logic wrclk = 0;
  logic [$size(dataout) - 1 : 0] datain;
  logic full, full_chk;
  logic rnd_start = 0;
always begin
  #5ns wrclk = ~wrclk;
end

always begin
  #3.33ns rdclk = ~rdclk;
end

async_fifo_wrapper #(.WIDTH(WIDTH), .SYNCWIDTH(3)) dut(.*);

  initial begin
    reset = 1'b1;
    repeat(3) @(posedge wrclk);
    reset = 1'b0;
    wait(full == 1'b0);
    @(posedge wrclk);
    for(int i = 0; i < DEPTH; i++) begin
      wr = 1;
      datain = i + 1;
      @(posedge wrclk);
    end
    wr = 0;
    wait(empty == 1'b1);
    rnd_start = 1;
    $display("[T=%0t], Finished linear test, starting random testing", $realtime);
    @(posedge wrclk);
    for(int i = 0; i < 10000; i++) begin
      datain = $urandom();
      @(posedge wrclk);
      wr = $urandom();
    end
    wr = 0;
    $display("[T=%0t], Finished random testing", $realtime);
  end

  initial begin
    #300ns;
    wait(full == 1'b1);
    repeat(3)@(posedge rdclk);
    for(int i = 0; i < DEPTH; i++) begin
      rd = 1;
      @(posedge rdclk);
    end
    rd = 0;    
    wait(rnd_start == 1'b1);

    for(int i = 0; i < 10000; i++) begin
      if(reset) begin //reset
        rd = 0;
        wait(reset == 1'b0);
        repeat(20) @(posedge wrclk);
      end else begin
        @(posedge rdclk);
        rd = $urandom();
      end
    end
    rd = 0;
  end


logic rd_del, valid_rd;


logic[WIDTH - 1 : 0] fifo_sw_model[$:DEPTH]; //bounded
logic[WIDTH - 1 : 0] expected_rd_data;
//self checking
always_ff@(negedge wrclk) begin
  if(reset) begin
    fifo_sw_model.delete();
  end else begin
    if(wr == 1'b1) begin
      fifo_sw_model.push_front(datain);
    end
  end
end

always_ff@(negedge rdclk) begin
    rd_del <= empty == 1'b0 && rd == 1'b1;
    if(fifo_sw_model.size() > 0 && rd_del) begin
        expected_rd_data = fifo_sw_model.pop_back();
        assert (dataout == expected_rd_data) else $error("[T=%0t], Data error, actual: %u, expected: %u", $realtime, dataout, expected_rd_data);
    end else if(fifo_sw_model.size() == 0 && rd_del) begin
        $error("[T=%0t], empty error", $time);
    end
end


endmodule