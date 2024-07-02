module Cau2(
    input CLOCK_50,
    input [1:0] SW,
    input [1:0] KEY,
    output reg [9:0] LEDR
);

    reg [24:0] counter;
    reg flag = 1'b1;

    always @(posedge CLOCK_50)
        counter <= counter + 1'b1;
                                 
    always @(negedge KEY[0])
    begin   
            if(KEY[0]) 
					flag = ~flag;	
        end     
   
       
    always @(posedge counter[22])
    begin
        if(flag) begin
				if(LEDR == 10'b0)
					LEDR <= 10'b1;
            else if(SW[0])
                LEDR <= {LEDR[8:0], LEDR[9]};
            else
                LEDR <= {LEDR[0], LEDR[9:1]};
        end
    end

endmodule
