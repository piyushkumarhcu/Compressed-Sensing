% function c=mycosamp(a,b)

fat = coder.load('f_humid.mat');      % Loading of original humidity data
f1 = fat.f_humid;               
      
Phil = coder.load('A_humid.mat');     % Loading of sensing matrix
A1 = Phil.A_humid;  
                  
Phil2 = coder.load('b_humid.mat');    % Loading of compressed humidity data
b1 = Phil2.b_humid;

K = 30;   						      % Sparsity 

[M,N] = size(A1);                     % Extraction of size from sensing matrix 

estSupportSet = [];    %zeros(1,30);  % First iteration blank index set

estX = zeros(N,1);                    % Initialization of solution set

temp2 = zeros(M,3*K);

interimSupportSet2 = zeros(3*K,1);    % First iteration blank interimSupportSet set

rk = b1;                              % Initialization of residual rk to b1 for first iteration

currResNorm = norm(rk,2);             % Calculation of norm(2) of residual

for itr_indx=1:K

    prev_estSupportSet = estSupportSet;       %Storing prevIk value
    prev_estX = estX;   % Nx1
    matchFilter = abs(A1'*rk);   %Nx1
    % Identify large components
    [~, index1] = sort(matchFilter, 'descend'); % index1= Nx1
    % Merge Supports
    interimSupportSet = union(estSupportSet, index1(1:2*K)'); % K<=|interimSupportSet|<=3K
                                      % size=2Kx1
                                      % For Each iteration Sets 2K are
                                      % added = (M-1)*K + M*2K
    % choose best k using least squares
    l = length(interimSupportSet);
    
    interimSupportSet2 = interimSupportSet';
     
    
    interimEstX = zeros(N,1);         % Nx1 = update 2Kx1 each time 2Kx1= Mx2K \ Mx1
    temp = A1(:,interimSupportSet2);
    [i,j] = size(temp);
    for s=1:i
         for f = 1:j
            temp2(s,f) = temp(s,f);
         end
    end
    
    C = temp2'*temp2;                 % Formation of a square matrix
	
    [L,D]=ldltn_hdl(C,itr_indx);      % Modified cholesky decomposition of the square matrix
	
    [IL]=Linv(L,itr_indx);            % Inversion of lower triangular matrix
	
    [inv_D]=d_inv_hdl(D,itr_indx);    % Inversion of diagonal matrix using Newton-Raphson method
	
    z=inv_D*IL;
	
    inv_C=(IL)'*z;
	
    temp3=inv_C;
	
    temp4=temp2'*b1;
	
    interimEstX1 = temp3*temp4;       % Moore-Penrose pseudoinverse of a tall matrix
%     len = length(interimEstX1);
    interimEstX2 = zeros(l,1);
    for t = 1:l
        interimEstX2(t) = interimEstX1(t);
    end
    interimEstX(interimSupportSet) = interimEstX2; 
    [~,index2] = sort(abs(interimEstX), 'descend'); %index2= Nx1
    
    
    estSupportSet = index2(1:K)';    % Extraction of support set (index) for next iteration   
    
    
    % estimate of the signal
    estX = zeros(N,1);              % Nx1
    estX(estSupportSet) = interimEstX(estSupportSet); 
	
    %update residue (CosaMP terminlology 'update current samples')
    rk = b1-A1*estX;  %Mx1= Mx1 - MxN * Nx1
	
    prevResNorm = currResNorm;
    currResNorm = norm(rk,2);
    if(prevResNorm <= currResNorm)
        estSupportSet = prev_estSupportSet;
        estX = prev_estX;
        break;
    end    
end

hat_f2=idct(estX);         % inverse IDCT of final solution

figure;
plot(f1);
hold on;
plot(hat_f2);

title('original vs reconstructed signal');

mae1=mae(f1-hat_f2);   %Calculation of mean absolute error between original and reconstructed data

rmse1 = immse(f1,hat_f2);    %Calculation of root mean square error between original and reconstructed data

% c=a+b+sum(x_hat);



