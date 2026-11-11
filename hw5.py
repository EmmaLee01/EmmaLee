import numpy as np
import pandas as pd


my_data = pd.read_csv("sim_data.csv", header=None).values.flatten()

sample_mean = np.mean(my_data)

n_bootstraps = 5000
bootstrapped_means = np.zeros(n_bootstraps)

for i in range(n_bootstraps):
    bootstrap_sample = np.random.choice(my_data, size=1000, replace=True)
    bootstrapped_means[i] = np.mean(bootstrap_sample)

mean_of_means = np.mean(bootstrapped_means)
var_of_means = np.var(bootstrapped_means, ddof=1)




def ar_samp(n):

    samples = []

    M = np.exp(1) * (4 / 27) 
    
    while len(samples) < n:
        x = np.random.uniform(0, 1)
        
        u = np.random.uniform(0, 1)
        
        fx = np.exp(np.cos(2 * np.pi * x)) * (x**2) * (1 - x)
        
        if u <= fx / M:
            samples.append(x)
            
    return samples



def mh_exp(start_point, num_samps):
    samples = np.zeros(num_samps)
    samples[0] = start_point
    
    def f(x):
        if x > 0:
            return np.exp(-x)
        else:
            return 0.0
            
    for t in range(1, num_samps):
        x_t = samples[t - 1]
        
        x_prop = np.random.normal(loc=x_t, scale=1.0)
        
        A = f(x_prop) / f(x_t)
        
        u = np.random.uniform(0, 1)
        
        if u < min(1.0, A):
            samples[t] = x_prop
        else:
            samples[t] = x_t
            
    return samples