`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 11:08:48 AM
// Design Name: 
// Module Name: tb_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm_tb;
    reg clk, reset, seq_in;
    wire moore_detected, mealy_detected;

    // Instantiate the Moore FSM for sequence "1100"
    moore_fsm moore_fsm_inst(
        .clk(clk),
        .reset(reset),
        .seq_in(seq_in),
        .detected(moore_detected)
    );

    // Instantiate the Mealy FSM for sequence "1101"
    mealy_fsm mealy_fsm_inst(
        .clk(clk),
        .reset(reset),
        .seq_in(seq_in),
        .detected(mealy_detected)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        seq_in = 0;
        #10 reset = 0;

        // Sequence to test Moore FSM (detects "1100") and Mealy FSM (detects "1101")
        $display("Starting sequence for Moore and Mealy FSMs:");
        
        // Test both FSMs with various input sequences
        seq_in = 1; #10;  // Start "1"
        seq_in = 1; #10;  // Continue "11"
        seq_in = 0; #10;  // Add "110"
        seq_in = 0; #10;  // Complete "1100" for Moore FSM
        $display("Moore FSM detected (1100): %b, Mealy FSM detected (1101): %b", moore_detected, mealy_detected);

        seq_in = 1; #10;  // Start "1" again
        seq_in = 1; #10;  // Continue "11"
        seq_in = 0; #10;  // Add "110"
        seq_in = 1; #10;  // Complete "1101" for Mealy FSM
        $display("Moore FSM detected (1100): %b, Mealy FSM detected (1101): %b", moore_detected, mealy_detected);

        // Test a different sequence to ensure FSMs do not trigger on non-matching sequences
        seq_in = 0; #10;
        seq_in = 1; #10;
        seq_in = 0; #10;
        seq_in = 1; #10;
        $display("Testing non-matching sequence. Moore FSM detected: %b, Mealy FSM detected: %b", moore_detected, mealy_detected);

        #20 $stop; // End the simulation
    end
endmodule

