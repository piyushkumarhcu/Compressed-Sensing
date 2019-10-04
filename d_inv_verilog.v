`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UoH 
// Engineer: Piyush Kumar
// 
// Create Date: 03/31/2018 10:23:57 AM
// Design Name: 
// Module Name: Diagonal Matrix Inverse   
// Project Name: d_inv_verilog
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
//////////////////////////////////////////////////////////////////////////////////


module d_inv_verilog(clk, rst, en, d_in, d_out, flag_out);

   input clk,rst,en;

   input [15:0] d_in;

   output reg flag_out;

   output reg [15:0] d_out;


   wire flag_rdy;


   reg [15:0] d_in_load;
   
  wire  [3:0] e_1;
   reg  [3:0] c_1;
   reg [15:0] n_1;
   reg [15:0] n_2=0;
   
   reg [47:0] b_1;
   reg [15:0] b_2;
   reg [47:0] b_3;
   reg [15:0] b_4;
   reg [47:0] b_5;
   reg [15:0] b_6;
   reg [47:0] b_7;
   reg [15:0] b_8;
   reg [47:0] b_9;
   reg [15:0] b_10;
   
   
   reg [31:0] d_1;
   reg [15:0] d_2;
   
   reg [31:0] x_1;
   reg [15:0] x_2;
   reg [47:0] x_3;
   reg [47:0] x_4 = 0;
   
   reg [31:0] d_out1;
   reg [15:0] d_out2;
   
log2_cal I2(.clk(clk), .rst(rst), .en(en), .v_in(d_in), .v_out(e_1), .flag_out(flag_rdy));       

 
     
 always@(posedge clk)
       begin
        if(rst==1) 
            begin
                d_out =0;
                flag_out=0;
            end
        else
            begin
                if (flag_rdy)
                    begin                                       
                        d_in_load = d_in;
                        c_1 = -(e_1 + 1);
                        n_1 = 2**c_1;//(n_1,16,16) (2^c_1)
                        if(n_1==1)
                            begin
                                n_2[14] = n_1[0];
                            end
                        else
                            begin
                                {n_2[15:14],n_2[13:0]} = {x_4[46:45],n_1[15:2]}; //(n_2,0,16,14)
                            end 
                         d_1 = (d_in_load)*(n_2);//(d_1,32,27)
                         d_2 = {d_1[29:27],d_1[26:14]}; //(d_2,16,13)                                     
                         x_1 = 757935405-61681*d_2;// (757935405 = (48/17,0,32,28).int  61681 = (32/17,0,16,15).int) (x_1,32,28)
                         x_2 = {x_1[31:28],x_1[27:16]};// (x_2,16,13)[DownConversion => (32,28)->(16,12)]                                                                            
                         {x_3[47:41],x_3[40:37],x_3[36:25],x_3[24:0]} = {x_4[47:41],x_2[15:12],x_2[11:0],x_4[24:0]};  //[UpConversion => (16,12)->(48,37)]  
                                                                       
                                        //Iteration-1 start
                         b_1 = x_3 + (x_2)*(33554432-d_2*x_2);  //(33554432 => fi(1,0,32,25).int  (x_3,48,39)  (b_1,48,37)
                                        //Iteration-1 End
                         b_2 = {b_1[40:37],b_1[36:25]};  // (b_2,16,13)[DownConversion => (48,37)->(16,12)]                                    
                                            
                                        //Iteration-2 start
                         b_3 = b_1 + (b_2)*(33554432-b_2*d_2);   //(b_3,48,37)
                                        //Iteration-2 End
                         b_4 = {b_3[40:37],b_3[36:25]};  //(b_4,16,13)[DownConversion => (48,37)->(16,12)]
                                            
                                        //Iteration-3 start
                         b_5 = b_3 + (b_4)*(33554432-b_4*d_2);   //(b_5,48,37)
                                        //Iteration-3 End
                         b_6 = {b_5[40:37],b_5[36:25]};  //(b_6,16,13)[DownConversion => (48,37)->(16,12)]
                                            
                                        //Iteration-4 start
                         b_7 = b_5 + (b_6)*(33554432-b_6*d_2);  //(b_7,48,37)
                                        //Iteration-4 End
                         b_8 = {b_7[40:37],b_7[36:25]};   //(b_8,16,13)[DownConversion => (48,37)->(16,12)]   
                                               
                                        //Iteration-5 start    
                         b_9 = b_7 + (b_8)*(33554432-b_8*d_2); //(b_9,48,37)
                                        //Iteration-5 End
                         b_10 = {b_9[40:37],b_9[36:25]};  //(b_10,16,13)[DownConversion => (48,37)->(16,12)]     
                                                    
                         d_out1 = (n_2)*(b_10);   //(d_out1,32,26)
                         d_out2  = {d_out1[29:26],d_out1[25:14]}; //[DownConversion => (32,28)->(16,12)](d_out,16,12)
                         d_out = d_out2;
                         flag_out = 1;    
                     end                                                                                                                               
              end                                       
       end

endmodule
