/*
module Cau3(
    input CLOCK_50,
    input KEY0,
    input KEY1,
    output reg [6:0] HEX0,
    output reg [6:0] HEX1,
    output reg [6:0] HEX2,
    output reg [6:0] HEX3
);

reg [23:0] counter;
reg [1:0] second, minute;
reg [3:0] sec0, sec1, min0, min1;
reg start;

// Clock divider to generate 1Hz signal
always @(posedge CLOCK_50)
begin
    if(counter == 24_000_000) begin
        counter <= 0;
        start <= 1;
    end
    else begin
        counter <= counter + 1'b1;
        start <= 0;
    end
end

// Counter for seconds and minutes
always @(posedge CLOCK_50)
begin
    if(KEY0)
        begin
            counter <= 0;
            second <= 0;
            minute <= 0;
        end
    else if(KEY1 && start) begin
        if(second == 59) begin
            second <= 0;
            if(minute == 59) begin
                minute <= 0;
            end
            else
                minute <= minute + 1'b1;
        end
        else
            second <= second + 1'b1;
    end
end

// Decode seconds and minutes for display
always @(*)
begin
    sec0 = second % 10;
    sec1 = second / 10;
    min0 = minute % 10;
    min1 = minute / 10;
end

// Module instantiation for 7-segment display decoder
decoder_7seg (sec0, HEX0);
decoder_7seg (sec1, HEX1);
decoder_7seg (min0, HEX2);
decoder_7seg (min1, HEX3);

endmodule


