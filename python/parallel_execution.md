

  * [Link](https://sebastianraschka.com/Articles/2014_multiprocessing.html)
  * [Link2](https://www.machinelearningplus.com/python/parallel-processing-python/)

````Python
import multiprocessing as mp
import os
import math
import time

# VER: https://www.machinelearningplus.com/python/parallel-processing-python/
# VER: https://docs.python.org/3/library/multiprocessing.html


def calc(p_value):

    print ('Calculating .. ' + p_value)
    time.sleep(5)
    print('DONE ' + p_value)

    """
    for i in range(0, 70000000):
        math.sqrt(i)
    """

    return 'RES[' + p_value + ']'

if __name__ == '__main__':

    # Initialize core pool to be the number of cpus available
    pool = mp.Pool(mp.cpu_count())

    try:
        # Create a list with the parameters to be used in each execution
        data = ['bla1', 'bla2', 'bla3', 'bla4', 'bla5', 'bla6', 'bla7', 'bla8'
                , 'bla9', 'bla10'
                ]

        # Call for the asynchronous execution of each run an await for them to conclude
        done = [pool.apply_async(calc, args=(value,)) for value in data]

        # Get and aggregate results
        output = [p.get() for p in done]
        for out in output:
            print(out)

    finally:
        # Close the created pool
        pool.close()

    print ('END')
````
