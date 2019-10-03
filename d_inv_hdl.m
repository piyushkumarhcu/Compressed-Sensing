
function ID= d_inv_hdl(D,itr_indx)     

K = 30;    %K is sparsity and itr_indx is the current iteration value

ID=zeros(3*K,3*K);

D2 = zeros(3*K,3*K);

N1 = zeros(3*K,3*K);

X = zeros(3*K,3*K);

E = zeros(3*K,3*K);

vect=zeros(3*K,1);

for j=1:itr_indx

[E(j,j)] = log2_coder(D(j,j)); % Exponent calculation
D2(j,j)=D(j,j)/2^(E(j,j)+1);
N1(j,j)=1/2^(E(j,j)+1) ;
X(j,j) = (48/17) - (32/17) * D2(j,j);  % First approximation of the Newton-Raphson

for i=1:20
X(j,j)= X(j,j)+ X(j,j) * (1 - D2(j,j) * X(j,j));  
end

vect(j)=N1(j,j)* X(j,j);
end

for k=1:itr_indx
    ID(k,k)=vect(k);
end