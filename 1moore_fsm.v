`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 11:00:49 AM
// Design Name: 
// Module Name: moore_fsm
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


module moore_fsm(clk, reset, seq_in, detected);
    input clk;
    input reset;
    input seq_in;
    output reg detected;
    
    // State encoding using parameters
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    
    reg [2:0] state, next_state;

    // State transition on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic and output assignment
    always @* begin
        // Default values
        detected = 0;
        next_state = state;

        // State transitions and output detection
        case (state)
            S0: next_state = seq_in ? S1 : S0;
            S1: next_state = seq_in ? S2 : S0;
            S2: next_state = seq_in ? S2 : S3;
            S3: next_state = seq_in ? S4 : S0;
            S4: begin
                detected = 1;      // Output signal goes high on sequence detection
                next_state = S0;   // Return to initial state
            end
            default: next_state = S0;
        endcase
    end
endmodule


