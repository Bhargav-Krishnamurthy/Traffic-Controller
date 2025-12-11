module tick1s(
    input wire clk,
    input wire reset,
    output reg tick
);
reg [27:0] counter = 0;
localparam maxval = 50 - 1;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        counter <= 0;
        tick <= 0;
    end
    else begin
        if(counter < maxval) begin
            counter <= counter + 1;
            tick <= 0;
        end
        else if(counter == maxval) begin
            tick <= 1;
            counter <= 0;

        end

    end


end


endmodule