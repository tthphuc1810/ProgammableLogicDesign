module decoder_7seg(bin, HEX0);
    input [3:0] bin;
    output [0:6] HEX0;

assign HEX0 = (bin == 4'd0) ? 7'b0000001:
              (bin == 4'd1) ? 7'b1001111:
              (bin == 4'd2) ? 7'b0010010:
              (bin == 4'd3) ? 7'b0000110:
              (bin == 4'd4) ? 7'b1001100:
              (bin == 4'd5) ? 7'b0100100:
              (bin == 4'd6) ? 7'b0100000:
              (bin == 4'd7) ? 7'b0001111:
              (bin == 4'd8) ? 7'b0000000:
              (bin == 4'd9) ? 7'b0000100:
              (bin == 4'd10) ? 7'b0001000: // Tương ứng với A
              (bin == 4'd11) ? 7'b1100000: // Tương ứng với B
              (bin == 4'd12) ? 7'b0110001: // Tương ứng với C
              (bin == 4'd13) ? 7'b1000010: // Tương ứng với D
              (bin == 4'd14) ? 7'b0110000: // Tương ứng với E
              (bin == 4'd15) ? 7'b0111000: // Tương ứng với F
              7'b1111111; 

endmodule