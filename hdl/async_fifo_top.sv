import async_pkg::*;

module async_fifo_top #(parameter WIDTH = 8,
                        parameter ADDRWIDTH = 3,
                        parameter SYNCWIDTH = 2,
                        parameter ENW = 1)( //will have to be derived in a wrapper module? This is frustrating
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

   (* ASYNC_REG = "TRUE" *) logic [SYNCWIDTH-1:0] rdrst_sync, wrrst_sync;
   (* ASYNC_REG = "TRUE" *) logic [SYNCWIDTH : 0][ADDRWIDTH : 0] rdGreyWrSync, wrGreyRdSync;
   logic [ADDRWIDTH : 0] rdAddr, wrAddr, rdGreyPtr, wrGreyPtr, wbnext, wgnext, rbnext, rgnext;
   logic [ADDRWIDTH - 1 : 0] bWrAddr;
   logic wr_int, rd_int;
   logic [WIDTH - 1 : 0] datain_int;


   assign wbnext = (full == 1'b0 && wr == 1'b1) ? wrAddr + 1'b1 : wrAddr;
   assign wgnext = myClass#(ADDRWIDTH+1)::bin2Gray(wbnext);
   always_ff@(posedge wrclk) begin

    wrrst_sync <= {wrrst_sync[$size(wrrst_sync) - 1 : 0], reset}; //cdc sync
    rdGreyWrSync <= {rdGreyWrSync[$size(rdGreyWrSync) - 1 : 0], rdGreyPtr}; //cdc sync
    wr_int <= 1'b0;
    datain_int <= datain;
    bWrAddr <= wrAddr[ADDRWIDTH - 1 : 0]; //pipeline reg delay to align correct address with wr_int/data_int
    if(wrrst_sync[$size(wrrst_sync) - 1]) begin
        wrAddr <= '0;
        full <= 1'b1; //default pessimism
    end else begin
        wrAddr <= wbnext;
        wr_int <= (full == 1'b0 && wr == 1'b1);
        wrGreyPtr <= wgnext;
        full <= (rdGreyWrSync[SYNCWIDTH][ADDRWIDTH] != wgnext[ADDRWIDTH]) &&
            (rdGreyWrSync[SYNCWIDTH][ADDRWIDTH - 1] != wgnext[ADDRWIDTH - 1]) &&
            (rdGreyWrSync[SYNCWIDTH][ADDRWIDTH - 2 : 0] == wgnext[ADDRWIDTH - 2 : 0]);
    end

   end

  

  assign rbnext = (empty == 1'b0 && rd == 1'b1) ? rdAddr + 1'b1 : rdAddr;
  assign rgnext = myClass#(ADDRWIDTH+1)::bin2Gray(rbnext);
  always_ff@(posedge rdclk) begin
    rdrst_sync <= {rdrst_sync[$size(rdrst_sync) - 1 : 0], reset}; //cdc sync
    wrGreyRdSync <= {wrGreyRdSync[$size(wrGreyRdSync) - 1 : 0], wrGreyPtr}; //cdc sync
    if(rdrst_sync[$size(rdrst_sync) - 1]) begin
        rdAddr <= '0;
        empty <= 1'b1; //default pessimism
    end else begin
        rd_int <= empty == 1'b0 && rd == 1'b1;
        rdAddr <= rbnext;
        rdGreyPtr <= rgnext;
        empty <= wrGreyRdSync[SYNCWIDTH] == rgnext;
    end   

  end



dualPortRAM#(.WIDTH(WIDTH), .ADDRW(ADDRWIDTH),.ENW(ENW))  tdp_ram( //only 8-36 supported

      .DOA(dataout),       // Output port-A data, width defined by READ_WIDTH_A parameter
      .DOB(),       // Output port-B data, width defined by READ_WIDTH_B parameter
      .ADDRA(rdAddr[$size(rdAddr) - 2 : 0]),   // based on max depth defined in table below
      .ADDRB(bWrAddr),   // based on max depth defined in table below
      .CLKA(rdclk),     // 1-bit input port-A clock
      .CLKB(wrclk),     // 1-bit input port-B clock
      .DIA('0),       // Input port-A data, width defined by WRITE_WIDTH_A parameter
      .DIB(datain_int),       // Input port-B data, width defined by WRITE_WIDTH_B parameter
      .RSTA(1'b0),     // 1-bit input port-A reset
      .RSTB(wrrst_sync[$size(wrrst_sync) - 1]),     // 1-bit input port-B reset
      .WEA('0),       // Input port-A write enable, width defined by Port A depth
      .WEB(wr_int)       // Input port-B write enable, width defined by Port B depth
);


endmodule