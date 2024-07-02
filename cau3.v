module cau3(
 clk,
 lap,
 ssr,
 view,
 
 HEX0,
 HEX1,
 HEX2,
 HEX3
);
 
 localparam PULSES_PER_SECOND = 100;
 localparam THRESHOLD = 5;
 
 input clk;
 input lap;
 input ssr;
 input view;
 
 output reg [6:0] HEX0;
 output reg [6:0] HEX1;
 output reg [6:0] HEX2;
 output reg [6:0] HEX3;
 
 reg [3:0] digits [0:2][0:5];
 reg pause = 1;
 wire [6:0] HEX [0:5];
 wire pulse;
 integer i;
 integer pulses = 0;
 
 pulse(clk, pulse);
 
 always @ (posedge pulse) begin
 
 if (pulse & ~pause) begin
 digits[0][0] = digits[0][0] + 1;
 digits[1][0] = digits[1][0] + 1;
 end
 
 if (digits[0][0] > 9) begin
 digits[0][0] = 0;
 digits[0][1] = digits[0][1] + 1;
 end
if (digits[0][1] > 9) begin
 digits[0][1] = 0;
 digits[0][2] = digits[0][2] + 1;
 end
 if (digits[0][2] > 9) begin
 digits[0][2] = 0;
 digits[0][3] = digits[0][3] + 1;
 end
 if (digits[0][3] > 5) begin
 digits[0][3] = 0;
 digits[0][4] = digits[0][4] + 1;
 end
 if (digits[0][4] > 9) begin
 digits[0][4] = 0;
 digits[0][5] = digits[0][5] + 1;
 end
 if (digits[0][5] > 5) begin
 digits[0][5] = 0;
 end
 
 if (digits[1][0] > 9) begin
 digits[1][0] = 0;
 digits[1][1] = digits[1][1] + 1;
 end
 if (digits[1][1] > 9) begin
 digits[1][1] = 0;
 digits[1][2] = digits[1][2] + 1;
 end
 if (digits[1][2] > 9) begin
 digits[1][2] = 0;
 digits[1][3] = digits[1][3] + 1;
 end
 if (digits[1][3] > 5) begin
 digits[1][3] = 0;
 digits[1][4] = digits[1][4] + 1;
 end
 if (digits[1][4] > 9) begin
 digits[1][4] = 0;
 digits[1][5] = digits[1][5] + 1;
 end
 if (digits[1][5] > 5) begin
 digits[1][5] = 0;
 end
 
 if (ssr) begin
 if (pulses > THRESHOLD) begin
 if (pulses < PULSES_PER_SECOND) begin
 pause = ~pause;
 end
 end
 pulses = 0;
 end else begin
 pulses = pulses + 1;
 if (pulses > PULSES_PER_SECOND) begin
 pause = 1;
 for (i = 0; i < 6; i = i + 1) digits[0][i] = 0;
 for (i = 0; i < 6; i = i + 1) digits[1][i] = 0;
 end
 end
 
 if (~lap) begin
 for (i = 0; i < 6; i = i + 1) digits[1][i] = 0;
 end
 
 if (view) begin
 for (i = 0; i < 6; i = i + 1) digits[2][i] = digits[1][i];
 end else begin
 for (i = 0; i < 6; i = i + 1) digits[2][i] = digits[0][i];
 end
 end
 
 bcd2ssd(digits[2][2], HEX[0]);
 bcd2ssd(digits[2][3], HEX[1]);
 bcd2ssd(digits[2][4], HEX[2]);
 bcd2ssd(digits[2][5], HEX[3]);
 
 always @ (HEX) begin
 
 HEX0 = HEX[0];
 HEX1 = HEX[1];
 HEX2 = HEX[2];
 HEX3 = HEX[3];
 end
endmodule