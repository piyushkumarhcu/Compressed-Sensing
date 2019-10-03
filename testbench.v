`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2019 07:18:23 PM
// Design Name: 
// Module Name: tb
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


module tb();

    reg clk=0; always #5 clk=!clk;
    reg rst=1; initial #13 rst=0;
    reg en;
    reg [15:0] d_in;
    wire [15:0] d_out;
    wire flag_out;
    
    reg [15:0] temp1;
    
    d_in_verilog dut(clk,rst,en,d_in,d_out,flag_out);
    
    initial begin
    
    #16 temp1=16'b0000010001000000; //fi(x,0,16,13)
        d_in=temp1;
        en=1;              
                    
        end
        
  
endmodule

