function [w,en,yn] = LMS(xn,dn,mu)
%LMS Implementation Algorithm
%   Inputs:
% xn   Input signal       Column vector
% dn   Desired signal     Column vector
% mu   Convergence factor (step size)  Scalar
% itr  Number of iterations  Scalar
% M    Filter order (number of taps)  Scalar
%   Outputs:
% w    Filter coefficient matrix    Size: M×itr  Each column represents coefficients after one iteration
% en   Error signal  Size: itr×1  Each row represents error after one iteration
% yn   Filter output signal  Column vector

M = 100; %Define filter order as 100
itr = length(xn); %Make the number of iterations equal to the length of input signal xn

w = zeros(M,itr);%Initialize filter coefficients to zero
en = zeros(itr,1);%Initialize error to zero

%Iteratively update filter parameters
for k = M:itr    %Ensure delayed input signal is valid, so actual iterations are only (itr-M) times
    x = xn(k:-1:k-M+1);%Delay the input signal so each tap of the filter has input
    y = w(:,k-1).'*x;  %Calculate filter output
    en(k) = dn(k)-y;   %Calculate error signal
    w(:,k) = w(:,k-1)+mu*en(k)*x;%Iteratively update filter coefficients
end
    

%After filter parameters are fixed, obtain output signal after filtering with optimized filter
yn = inf*ones(length(xn));%inf means infinity, initialize yn to infinity so it won't be displayed when plotting

for k = 1:M-1
    yn(k) = xn(k);
end

for k = M:itr
    x = xn(k:-1:k-M+1);
    yn(k) = w(:,k).'*x;
end
    
end
