`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2019 03:05:02 PM
// Design Name: 
// Module Name: venkat_log2
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



module log2_cal(clk,rst,en,v_in,v_out,flag_out);
    
    input clk;
    input rst;
    input en;
    input [15:0] v_in; //(16,13)
    output reg [3:0] v_out;
    output reg flag_out;         
always@(posedge clk) 
begin
    if(rst) begin
        v_out    <=0;
        flag_out <=0;
    end 
    else if(en) begin
            if(v_in[15:13]>=1) begin
                if(v_in[15]) v_out<= 3;
                else if(v_in[14]) v_out<= 2;
                else if(v_in[13]) v_out<= 1;
                flag_out<=1;
            end
            else begin 
                if(v_in[12]) v_out<= -1;
                else if(v_in[11]) v_out<= -1;
                else if(v_in[10]) v_out<= -2;
                else if(v_in[9])  v_out<= -3;
                else if(v_in[8])  v_out<= -4;
                else if(v_in[7])  v_out<= -5;
                else if(v_in[6])  v_out<= -6;
                else if(v_in[5])  v_out<= -7;
                else if(v_in[4])  v_out<= -8;
                else if(v_in[3])  v_out<= -9;
                else if(v_in[2])  v_out<= -10;
                else if(v_in[1])  v_out<= -11;
                else if(v_in[0])  v_out<= -12;
                flag_out<=1;
                 end
                 
    end 
                
end
endmodule
