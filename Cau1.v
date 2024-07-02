module Cau1(
 input [0:2] KEY, //KEY[] = S[]
 input [7:0] SW, //SW[] = A[]
 output LED0 //LED0 = Y
);
wire c0, c1, c2, c3, c4, c5, c6, c7;
assign c0 = SW[0] & ~KEY[0] & ~KEY[1] & ~KEY[2];
assign c1 = SW[1] & ~KEY[0] & ~KEY[1] & KEY[2];
assign c2 = SW[2] & ~KEY[0] & KEY[1] & ~KEY[2];
assign c3 = SW[3] & ~KEY[0] & KEY[1] & KEY[2];
assign c4 = SW[4] & KEY[0] & ~KEY[1] & ~KEY[2];
assign c5 = SW[5] & KEY[0] & ~KEY[1] & KEY[2];
assign c6 = SW[6] & KEY[0] & KEY[1] & ~KEY[2];
assign c7 = SW[7] & KEY[0] & KEY[1] & KEY[2];
assign LED0 = c0 | c1 | c2 | c3 | c4 | c5 | c6 | c7;
endmodule
