clear
clc

n = 1000;     % number of negatives
n1 = 250;     % number of positives
alpha = 0.15; % true mixing proportion (class prior)

% the number of positive and negative data points in unlabeled data
p(2) = round(alpha * n);
p(1) = n - p(2);

% Means and covariance matrices of the two Gaussian distributions
m = [[4 4]' [6 3]'];           % true means
S(:, :, 1) = [1 0.75; 0.75 1]; % true covariance matrices
S(:, :, 2) = [1 0.75; 0.75 1]; 

%m = [[4 4]' [6 3]'];             % true means
%S(:, :, 1) = [1 -0.75; -0.75 1]; % true covariance matrices
%S(:, :, 2) = [1 0.75; 0.75 1]; 

%m = [[1 2]' [6 3]'];           % true means
%S(:, :, 1) = [1 0; 0 1];       % true covariance matrices
%S(:, :, 2) = [1 0.75; 0.75 1]; 

%% Generate data sets X and X1
X = [];
for k = 1 : 2
    X = [X; repmat(m(:, k)', p(k), 1) + randn(p(k), 2) * chol(S(:, :, k))];
end

X1 = repmat(m(:, 2)', n1, 1) + randn(n1, 2) * chol(S(:, :, 2));

%% Get to estimation work
opts.transform=@(X,X1)(transform_nn(X,X1,struct('h',7)));
[est, out] = estimateMixprop(X, X1,'AlphaMax',opts);
