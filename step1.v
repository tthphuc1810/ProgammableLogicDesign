module step1(
    input wire clk,
    input wire reset,
    output reg i2c_sda,
    output reg i2c_scl
);

//goal is to write to device address 0x50,0xaa
localparam STATE_IDLE = 0; 
localparam STATE_START = 1; 
localparam STATE_ADDR = 2; 
localparam STATE_RW = 3; 
localparam STATE_WACK = 4; 
localparam STATE_DATA = 5;  // Corrected from STATE_DATE to STATE_DATA
localparam STATE_STOP = 6; 
localparam STATE_WACK2 = 7;
reg [7:0] state;
reg [6:0] addr;
reg [7:0] count;
reg [7:0] data;

always @(posedge clk) begin
    if (reset == 1) begin
        state <= 0; 
        i2c_sda <= 1; 
        i2c_scl <= 1;
        addr <= 7'h50;
        count <= 8'd0;
        data <= 8'haa;
    end
    else begin
        case (state)
            STATE_IDLE: begin // idle
                i2c_sda <= 1;
                state <= STATE_START; 
            end // end start idle   

            STATE_START: begin  // start
                i2c_sda <= 1;
                state <= STATE_ADDR; 
                count <= 6;
            end // end state start

            STATE_ADDR: begin  // msb address bit
                i2c_sda <= addr[count];
                if (count == 0) 
                    state <= STATE_RW;
                else 
                    count <= count - 1;
            end // end state addr 

            STATE_RW: begin 
                i2c_sda <= 1;
                state <= STATE_WACK;
            end // end state rw

            STATE_WACK: begin 
                state <= STATE_DATA; 
            end // end state wack 

            STATE_DATA: begin    
                i2c_sda <= data[count];
                if (count == 0) 
                    state <= STATE_WACK2;
                else 
                    count <= count - 1;
            end // end state data 

            STATE_WACK2: begin 
                state <= STATE_STOP;
            end // end state wack2

            STATE_STOP: begin 
                state <= STATE_IDLE;
            end // end state stop
        endcase
    end
end

endmodule