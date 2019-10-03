function [E] = log2_coder2(x)

count = 1;

k = x;
     
 for i=1:10
       
   if k>2
       
    k = (k/2);
    
    count = count + 1;  
    
   end 
   
 end
    
E = count;

%F = x*(2^-E);
