
function  IL=Linv_hdl(L,itr_indx)

K = 30;    %K is sparsity and itr_indx is the current iteration value

IL=zeros(3*K,3*K);

for i=1:itr_indx

     IL(i,i)=1;
end
   
    for i=1:itr_indx   %rows
        for j=1:itr_indx  %columns
       
            if(i>j)
                sum1=0;
                for k=j:i-1
                    temp= -L(i,k)*IL(k,j);
                    sum1=sum1+temp;
                end
                 IL(i,j)=sum1;
            end
            
        end
    end
end




