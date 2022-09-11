This software contains an implementation of the AlphaMax algorithm for class prior estimation in positive-unlabeled learning with and without noisy labels [1-2]. 

Author: Shantanu Jain

Please look at estimateMixprop.m and test.m to get started.
	Some manual intervention is suggested for the code. To elaborate, we use a grid of alpha (class priors) values between 0 and 1. When I use the code I generally set it to 0.001:0.001:0.999 (the default is 0.01, 0.02, ... 0.99). The code will run and calculate the likelihood for each of these points. Finally, once the 1000 data points are plotted, we run an inflection script (Algorithms/inflectionScript.m) to identify a point of the sharpest transition. That algorithm is not perfect and I would also recommend a manual inspection of the results when you get an output.
	Because we use a window-based approach in the inflection script (with +/- 3 points from a center) this script does not work well when alpha* is very low or very high. In these cases, the inflection script might give you a random proportion, so you need to correct manually. 
	Note that the algorithm relies on a univariate transform of the data, given by the score function of a classifier trained to separate the positives from unlabeled examples. Using an ensemble of neural networks trained via bagging gave the best transform in our experiments. The code uses an ensemble of 100 networks with 5 hidden neurons. However, if using a larger ensemble and a more complex network, gives a higher out-of-bag AUCPU (AUC for separating positives from unlabeled example), you should use it as a transform.

[1] Jain S, White M, Trosset MW, Radivojac P (2016). Nonparametric semi-supervised learning of
class proportions. arXiv preprint: arXiv:1601.01944.
[2] Jain S, White M, Radivojac P (2016). Estimating the class prior and posterior from noisy
positives and unlabeled data. Advances in Neural Information Processing Systems, 29: 2693-
2701.

