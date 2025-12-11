`timescale 1ns/1ps

module tb_traffic;

    reg clk = 0;
    reg reset = 1;
    reg extension = 0;

    wire tick;

    wire ns_green, ns_yellow, ns_red;
    wire ew_green, ew_yellow, ew_red;

    always #5 clk = ~clk;

    tick1s tickgen(
        .clk(clk),
        .reset(reset),
        .tick(tick)
    );

    traffic dut(
        .clk(clk),
        .reset(reset),
        .tick(tick),
        .extension(extension),
        .ns_green(ns_green),
        .ns_yellow(ns_yellow),
        .ns_red(ns_red),
        .ew_green(ew_green),
        .ew_yellow(ew_yellow),
        .ew_red(ew_red)
    );

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb_traffic);

        #100 reset = 0;

        repeat(5) @(posedge tick);

        extension = 1;
        @(posedge tick);
        extension = 0;

        repeat(20) @(posedge tick);

        $finish;
    end

endmodule
