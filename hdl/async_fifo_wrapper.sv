module async_fifo_wrapper #(parameter WIDTH = 8,
                        parameter SYNCWIDTH = 2)(
  input reset,
  //rdclk domain
  input rd,
  output logic [WIDTH - 1 : 0] dataout,
  input rdclk,
  output logic empty,

  //wrclk domain
  input wr,
  input wrclk,
  input logic [$size(dataout) - 1 : 0] datain,
  output logic full
);

// assert (WIDTH <= 36) else $error("fifo width error: %u, expected must be less than or equal to 36 bits", $realtime, WIDTH);

generate
    if(WIDTH <= 9) begin
        async_fifo_top #(.WIDTH(WIDTH),.ADDRWIDTH(12),.SYNCWIDTH(SYNCWIDTH),.ENW(1)) //4096 depth
        async_fifo_inst(.*);

    end else if(WIDTH <= 18) begin
        async_fifo_top #(.WIDTH(WIDTH),.ADDRWIDTH(11),.SYNCWIDTH(SYNCWIDTH),.ENW(2)) //2048 depth
        async_fifo_inst(.*);
    end else begin
        async_fifo_top #(.WIDTH(WIDTH),.ADDRWIDTH(10),.SYNCWIDTH(SYNCWIDTH),.ENW(4)) //1024 depth
        async_fifo_inst(.*);
    end
endgenerate


endmodule