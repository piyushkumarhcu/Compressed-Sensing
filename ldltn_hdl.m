% Modified Cholesky factorization method has advantages over other matrix inversion techniques as it does not require square-root operation
%
% This method decomposed the given square matrix into a lower triangular and diagonal matrix.
%
% G = FHF'

function [L,D]=ldltn_hdl(C_mat,itr_indx)
 
K = 30; %K is sparsity and itr_indx is the current iteration value

L=zeros(3*K,3*K);
d=zeros(1,3*K);
D=zeros(3*K,3*K);
v=zeros(1,3*K);
x=zeros(1,3*K);

a1=zeros(3*K,1);
b1=zeros(3*K,3*K);
f=zeros(3*K,3*K);
g=zeros(3*K,1);

for j=1:itr_indx
  if (j > 1)
      for k=1:j-1
		v(k)=L(j,k).*d(k);
		x(k)=L(j,k);
		v(j)=C_mat(j,j)-x*v';
      end
  d(j)=v(j);
  
  if (1<j && j < itr_indx)
      for p=j+1:itr_indx
          a1(p)=C_mat(p,j);
          g(p)=0;
          for k=1:j-1
			b1(p,k)=L(p,k);     
			f(p,k)=(b1(p,k)*v(k)');
			g(p)=g(p)+f(p,k);
			L(p,j)=(a1(p)-g(p))/v(j);
          end
         
      end
      
  end  
          
      else
		v(1)=C_mat(1,1);
		d(1)=v(1); 
    for i=2:itr_indx
        L(i,1)=C_mat(i,1)/v(1);
    end
  end 
end
for i=1:itr_indx
	D(i,i)=d(1,i);
    L(i,i)=1;
end
      

