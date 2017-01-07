
function [params]=alpha_loglik(data)


%--------------------------------------------------------------------------
%
%	DESCRIPTION:
%
%	A quantile approach for estimating the parameters of an 
%
%   alpha-stable distribution S(alpha,beta,gamma,delta), where:
%
%   'alpha' denotes the stability paramter and is defined over the interval (0,2],
%
%   'beta' is the skewness parameter defined over [-1,1]
%
%   'gamma' is the scale parameter defined over the positive real line,
%
%   'delta' is the location parameter defined over the entire real line. 
%
%   The quantile estimation method is proposed by McCulloch (1986).
%
%
%   REFERENCE:
%
%   McCulloch, J. H. (1986), 
%
%   "Simple consistent estimators of stable distribution parameters", 
%
%   published in Communications in Statistics, Simulation and Computation, 
%
%   Vol. 15, pp. 1109-1136.
%
%--------------------------------------------------------------------------
%
%   INPUT:
%
%    data: vector of observations
%
%--------------------------------------------------------------------------
%
%   OUTPUT:
%
%	 params_output: structure containing the distribution parameters
% 
%    params_output.alpha: the stability parameter 'alpha'
%    params_output.bet:   the skewness parameter 'beta'
%    params_output.gamm:  the scale parameter 'gamma'
%    params_output.delt:   the location parameter 'delta'
%
%--------------------------------------------------------------------------
%
%	Author:  Paolo Z., January 2012
%
%--------------------------------------------------------------------------



%--------------------------------------------------------------------------
% Compute quantiles
data   = sort(data);
perc05 = prctile(data, 5);
perc25 = prctile(data, 25);
perc50 = prctile(data, 50);
perc75 = prctile(data, 75);
perc95 = prctile(data, 95);

% Compute quantile statistics
v_a = (perc95 - perc05)./(perc75 - perc25);
v_b = (perc95 + perc05 - 2*perc50)./(perc95 - perc05);
v_c = perc75 - perc25;

% Define interpolation matrices 
xi_1 = [2,     2,     2,     2,     2,     2,     2;
        1.916, 1.924, 1.924, 1.924, 1.924, 1.924, 1.924;
        1.808, 1.813, 1.829, 1.829, 1.829, 1.829, 1.829;
        1.729, 1.730, 1.737, 1.745, 1.745, 1.745, 1.745;
        1.664, 1.663, 1.663, 1.668, 1.676, 1.676, 1.676;
        1.563, 1.560, 1.553, 1.548, 1.547, 1.547, 1.547;
        1.484, 1.480, 1.471, 1.460, 1.448, 1.438, 1.438;
        1.391, 1.386, 1.378, 1.364, 1.337, 1.318, 1.318;
        1.279, 1.273, 1.266, 1.250, 1.210, 1.184, 1.150;
        1.128, 1.121, 1.114, 1.101, 1.067, 1.027, 0.973;
        1.029, 1.021, 1.014, 1.004, 0.974, 0.935, 0.874;
        0.896, 0.892, 0.884, 0.883, 0.855, 0.823, 0.769;
        0.818, 0.812, 0.806, 0.801, 0.780, 0.756, 0.691;
        0.698, 0.695, 0.692, 0.689, 0.676, 0.656, 0.597;
        0.593, 0.590, 0.588, 0.586, 0.579, 0.563, 0.513];

xi_2 = [0, 2.160, 1,     1,     1,     1,     1;
        0, 1.592, 3.390, 1,     1,     1,     1;
        0, 0.759, 1.800, 1,     1,     1,     1;
        0, 0.482, 1.048, 1.694, 1,     1,     1;
        0, 0.360, 0.760, 1.232, 2.229, 1,     1;
        0, 0.253, 0.518, 0.823, 1.575, 1,     1;
        0, 0.203, 0.410, 0.632, 1.244, 1.906, 1;
        0, 0.165, 0.332, 0.499, 0.943, 1.560, 1;
        0, 0.136, 0.271, 0.404, 0.689, 1.230, 2.195;
        0, 0.109, 0.216, 0.323, 0.539, 0.827, 1.917;
        0, 0.096, 0.190, 0.284, 0.472, 0.693, 1.759;
        0, 0.082, 0.163, 0.243, 0.412, 0.601, 1.596;
        0, 0.074, 0.147, 0.220, 0.377, 0.546, 1.482;
        0, 0.064, 0.128, 0.191, 0.330, 0.478, 1.362;
        0, 0.056, 0.112, 0.167, 0.285, 0.428, 1.274];

xi_3 = [1.908, 1.908, 1.908, 1.908, 1.908;
        1.914, 1.915, 1.916, 1.918, 1.921;
        1.921, 1.922, 1.927, 1.936, 1.947;
        1.927, 1.930, 1.943, 1.961, 1.987;
        1.933, 1.940, 1.962, 1.997, 2.043;
        1.939, 1.952, 1.988, 2.045, 2.116;
        1.946, 1.967, 2.022, 2.106, 2.211;
        1.955, 1.984, 2.067, 2.188, 2.333;
        1.965, 2.007, 2.125, 2.294, 2.491;
        1.980, 2.040, 2.205, 2.435, 2.696;
        2,     2.085, 2.311, 2.624, 2.973;
        2.040, 2.149, 2.461, 2.886, 3.356;
        2.098, 2.244, 2.676, 3.265, 3.912;
        2.189, 2.392, 3.004, 3.844, 4.775;
        2.337, 2.634, 3.542, 4.808, 6.247;
        2.588, 3.073, 4.534, 6.636, 9.144];
  
  
xi_4 = [0,  0,      0,      0,      0;  
        0, -0.017, -0.032, -0.049, -0.064;
        0, -0.030, -0.061, -0.092, -0.123;
        0, -0.043, -0.088, -0.132, -0.179;
        0, -0.056, -0.111, -0.170, -0.232;
        0, -0.066, -0.134, -0.206, -0.283;
        0, -0.075, -0.154, -0.241, -0.335;
        0, -0.084, -0.173, -0.276, -0.390;
        0, -0.090, -0.192, -0.310, -0.447;
        0, -0.095, -0.208, -0.346, -0.508;
        0, -0.098, -0.223, -0.380, -0.576;
        0, -0.099, -0.237, -0.424, -0.652;
        0, -0.096, -0.250, -0.469, -0.742;
        0, -0.089, -0.262, -0.520, -0.853;
        0, -0.078, -0.272, -0.581, -0.997;
        0, -0.061, -0.279, -0.659, -1.198];

    
tv_1 = [2.4, 2.5, 2.6, 2.7, 2.8, 3,   3.2, 3.5, 4, 5, 6, 8, 10, 15, 25];
tv_2 = [0,   0.1, 0.2, 0.3, 0.5, 0.7, 1];

t_1 = [2, 1.9,  1.8, 1.7,  1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1, 0.9, 0.8, 0.7, 0.6, 0.5];
t_2 = [0, 0.25, 0.5, 0.75, 1];    
%--------------------------------------------------------------------------
  

%--------------------------------------------------------------------------  
% Compute estimates by interpolationg through the tables
[nrow, ncol] = size(data);

if (nrow==1) 
	ncol = 1; 
end

%--------------------------------------------------------------------------
%beginning of main loop
for (n=1:ncol)    
    
	tv_1_1 = max([1 find(tv_1 <= v_a(n))]);
	tv_1_2 = min([15 find(tv_1 >= v_a(n))]);
  
	tv_2_1 = max([1 find(tv_2 <= abs(v_b(n)))]);
	tv_2_2 = min([7 find(tv_2 >= abs(v_b(n)))]);
  
	distnc = tv_1(tv_1_2) - tv_1(tv_1_1);
  
	%------------------------------------------------------------------------
	if (distnc~=0)
        distnc = (v_a(n) - tv_1(tv_1_1))/distnc;
    end
	%------------------------------------------------------------------------
    
	distnc1 = tv_2(tv_2_2) - tv_2(tv_2_1);
  
	%------------------------------------------------------------------------
	if (distnc1~=0)
        distnc1 = (abs(v_b(n)) - tv_2(tv_2_1))/distnc1;
    end
	%------------------------------------------------------------------------
  
	xi_1_b1 = distnc*xi_1(tv_1_2,tv_2_1) + (1-distnc)*xi_1(tv_1_1,tv_2_1);
    xi_1_b2 = distnc*xi_1(tv_1_2,tv_2_2) + (1-distnc)*xi_1(tv_1_1,tv_2_2);
  
    alph(n) = distnc1*xi_1_b2 + (1-distnc1)*xi_1_b1;
  
    xi_2_b1 = distnc*xi_2(tv_1_2,tv_2_1) + (1-distnc)*xi_2(tv_1_1,tv_2_1);
    xi_2_b2 = distnc*xi_2(tv_1_2,tv_2_2) + (1-distnc)*xi_2(tv_1_1,tv_2_2);
  
    bet(n) = sign(v_b(n))*(distnc1*xi_2_b2+(1-distnc1)*xi_2_b1);
  
    t_1_1 = max([1 find(t_1 >= alph(n))]);
    t_1_2 = min([16 find(t_1 <= alph(n))]);
  
    t_2_1 = max([1 find(t_2 <= abs(bet(n)))]);
    t_2_2 = min([5 find(t_2 >= abs(bet(n)))]);
  
    distnc = t_1(t_1_2) - t_1(t_1_1);
  
    %------------------------------------------------------------------------
    if (distnc~=0)
        distnc = (alph(n)-t_1(t_1_1))/distnc;
    end
    %------------------------------------------------------------------------
  
    distnc1 = t_2(t_2_2) - t_2(t_2_1);
  
    %------------------------------------------------------------------------
    if (distnc1~=0)
        distnc1 = (abs(bet(n)) - t_2(t_2_1))/distnc1;
    end
    %------------------------------------------------------------------------
  
    xi_3_b1 = distnc*xi_3(t_1_2,t_2_1) + (1-distnc)*xi_3(t_1_1,t_2_1);
    xi_3_b2 = distnc*xi_3(t_1_2,t_2_2) + (1-distnc)*xi_3(t_1_1,t_2_2);
  
    gamm(n) = v_c(n)/(distnc1*xi_3_b2 + (1-distnc1)*xi_3_b1);
  
    xi_4_b1 = distnc*xi_4(t_1_2,t_2_1) + (1-distnc)*xi_4(t_1_1,t_2_1);
    xi_4_b2 = distnc*xi_4(t_1_2,t_2_2) + (1-distnc)*xi_4(t_1_1,t_2_2);
  
    zeta = sign(bet(n))*gamm(n)*(distnc1*xi_4_b2 + (1-distnc1)*xi_4_b1) + perc50;
  
    %------------------------------------------------------------------------
    if (abs(alph(n)-1)<0.05)
        delt(n) = zeta;
    else
        delt(n) = zeta-bet(n)*gamm(n)*tan(0.5*pi*alph(n));
    end
    %------------------------------------------------------------------------
  
%end of main loop  
end
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% Correct estimates for out of range values
alph(alph <= 0) = 1e-100;
alph(alph > 2)  = 2;
gamm(gamm <= 0) = 1e-100;
bet(bet < -1)   = -1;
bet(bet > 1)    = 1;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
params.alph = alph;
params.bet  = bet;
params.gamm = gamm;
params.delt = delt;
%--------------------------------------------------------------------------