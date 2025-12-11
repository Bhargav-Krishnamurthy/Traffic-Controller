module traffic(
    input wire clk,
    input wire reset,
    input wire tick,
    input wire extension,
    output reg ns_green,
    output reg ns_yellow,
    output reg ns_red,
    output reg ew_green,
    output reg ew_yellow,
    output reg ew_red
);

reg [4:0] counter;
initial counter = 1;
reg [4:0] t1 = 10;
reg [4:0] t2 = 13;
reg [4:0] t3 = 23;

always @(posedge clk or posedge reset) begin

    if(reset) begin
        counter <= 1;
        t1<= 10;
        t2<=13;
        t3<=23;
    end
    else if (tick) begin  
        if (extension && counter <= t1) begin
            t1 <= t1 + 5;         
            t2 <= t1 + 5 + 3;    
            t3 <= t1 + 5 + 3 + 10; 
        end
        if(counter <= t1) begin
            counter <= counter + 1;
            ns_green <= 1;
            ns_yellow <= 0;
            ns_red <= 0;
            ew_green <= 0;
            ew_yellow <= 0;
            ew_red <= 1;
        end
        else if(counter<=t2) begin
            counter <= counter + 1;
            ns_green <= 0;
            ns_yellow <= 1;
            ns_red <= 0;
            ew_green <= 0;
            ew_yellow <= 0;
            ew_red <= 1;
        end
        else if (counter<=t3) begin
            counter <= counter + 1;
            ns_green <= 0;
            ns_yellow <= 0;
            ns_red <= 1;
            ew_green <= 1;
            ew_yellow <= 0;
            ew_red <= 0;
        end
        else if(counter <= t3+3) begin
            counter <= counter + 1;
            ns_green <= 0;
            ns_yellow <= 0;
            ns_red <= 1;
            ew_green <= 0;
            ew_yellow <= 1;
            ew_red <= 0;
        end
        else begin
            counter <= 1;
            t1<= 10;
            t2<=13;
            t3<=23;
        end
    end
end
