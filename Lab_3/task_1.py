import random
import math
import time
from collections import defaultdict

def simple_hash(value, m):
    return value % m

def hash_1(value, a, b, m):
    return (a * value + b) % m

def gen_random_params(p):
    a = random.randint(1, p - 1)
    b = random.randint(0, p - 1)
    return a, b

def first_prime_greater(m):
    for possible in range(m + 1, 2 * m):
        isPrime = True
        for i in range(2, possible):
            if possible % i == 0:
                isPrime = False
                break
        if isPrime == True:
            return possible

def test(m, start, end, change):


    dict_first = defaultdict(int)

    simple_time_start = time.time()
    dict_simple = defaultdict(int)
    for i in range(start, end + change, change):
        value = random.randint(0, m - 1)
        dict_simple[simple_hash(value, m)] += 1
    simple_time = time.time() - simple_time_start
    print("Simple hash time: {}".format(simple_time))

    first_time_start = time.time()
    p = first_prime_greater(m)
    a, b = gen_random_params(p)
    for i in range(start, end + change, change):
        value = random.randint(0, m - 1)
        dict_first[hash_1(value, a, b, m)] += 1
    first_time = time.time() - first_time_start
    print("First hash time: {}".format(first_time))

    return dict, dict_first



def entrophy(dict):
    sum_values = sum(dict.values())
    entr = 0
    for item in dict.values():
        prob = item / sum_values
        if prob > 0:
            entr += prob * math.log10(prob)
    return -entr

def max_entrophy(dict):
    sum_values = sum(dict.values())
    return -math.log10(1 / sum_values)

def square_err(dict):
    sum_values = sum(dict.values())
    err = 0
    for item in dict.values():
       x = (item / sum_values) - (1 / sum_values)
       err += x * x
    return (1 / sum_values) * err

params = [(0, 100000000-1, 1), (0, 200000000-1, 2), [1, 200000000-1], 2]
m_size = [10, 1000, 100000]
