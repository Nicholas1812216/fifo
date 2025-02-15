`timescale 1ps/1ps
module simple_fifo #(parameter WIDTH = 8,
         parameter DEPTH = 32,
         parameter SYNC_DEPTH = 2)(
           input rst,
           input clk,
           input wr,
           input rd,
           input [WIDTH - 1 : 0] data_in,
           output logic [WIDTH - 1 : 0] data_out,
           output logic empty,
           output logic full
         );

        logic [DEPTH - 1 : 0][WIDTH - 1 : 0] memory;
        logic [$clog2(DEPTH) - 1 : 0] rd_addr;

        (* ASYNC_REG = "TRUE" *) logic [SYNC_DEPTH - 1:0] rst_sync; 

        logic [$clog2(DEPTH) : 0] num_entries;
        logic [$clog2(DEPTH) - 1 : 0] wr_addr;

        assign full = num_entries == DEPTH;
        assign data_out = memory[rd_addr];

        always_ff@(posedge clk) begin
            rst_sync <= {rst_sync[SYNC_DEPTH - 2 : 0], rst};
            if(rst_sync[SYNC_DEPTH - 1] == 1'b1) begin
                wr_addr <= '0;
            end else begin
                if(wr == 1'b1 && full == 1'b0) begin
                    wr_addr <= wr_addr + 1'b1;
                    memory[wr_addr] <= data_in;
                end 
            end
        end


        always_ff@(posedge clk) begin
            if(rst_sync[SYNC_DEPTH - 1] == 1'b1) begin
                rd_addr <= '0;
            end else begin
                if(rd == 1'b1 && empty == 1'b0) begin
                    rd_addr <= rd_addr + 1'b1;
                end 
            end
        end      

        always_ff@(posedge clk) begin
          empty <= num_entries == '0;
          if(rst_sync[SYNC_DEPTH - 1] == 1'b1) begin
            num_entries <= '0;
          end else begin
            if(rd == 1'b1 && empty == 1'b0 && wr == 1'b1 && num_entries < DEPTH) begin //successful wr & rd
              num_entries <= num_entries;
            end else if(rd == 1'b1 && empty == 1'b0) begin //successful rd
              num_entries <= num_entries - 1'b1;
              if(num_entries == 1'b1) begin
                empty <= 1'b1;
              end
            end else if(wr == 1'b1 && num_entries < DEPTH) begin //successful wr
              num_entries <= num_entries + 1'b1;
            end
          end
        end


endmodule