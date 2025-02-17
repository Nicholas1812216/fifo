package async_pkg;

virtual class myClass#(parameter WIDTH = 8);
    static function logic [WIDTH - 1 : 0] bin2Gray;
        input logic [WIDTH-1:0] binary;
        begin
          logic [WIDTH - 1 : 0] retVal;
          for(int i = 0; i < WIDTH - 1; i++) begin
            retVal[i] = binary[i] ^ binary[i + 1];
          end
          retVal[WIDTH - 1] = binary[WIDTH - 1];
          return retVal;
        end
    endfunction

    static function logic[WIDTH - 1 : 0] gray2Bin;
        input logic [WIDTH-1:0] Gray;
        begin
          logic [WIDTH - 1 : 0] retVal;
          retVal[WIDTH - 1] = Gray[WIDTH - 1];
          for(int i = WIDTH - 2; i >= 0; i= i - 1) begin
            retVal[i] = Gray[i] ^ retVal[i + 1];
          end
          return retVal;
        end
    endfunction

endclass

endpackage