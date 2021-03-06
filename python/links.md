# Python
  
  * [PY-NOOB](https://github.com/NARCOTIC/PY-NOOB)
  * [GIST :: fomightez/useful_pandas_snippets.py](https://gist.github.com/fomightez/ef57387b5d23106fabd4e02dab6819b4)

## Interesting Libraries
  * [Gooey](https://github.com/chriskiehl/Gooey#what-is-it)
  * [Top 15 Packages](https://python.land/top-15-python-packages)
  * [CherryPy - A Minimalist Python Web Framework](https://cherrypy.org/)
  * [Spyre is a Web Application Framework for providing a simple user interface for Python data projects](https://github.com/adamhajari/spyre)
  * [5 Interesting Python Libraries - Data visualization on the CLI](https://towardsdatascience.com/5-interesting-python-libraries-1395c791deb5)
  * [Stop Using Print to Debug in Python. Use Icecream Instead](https://towardsdatascience.com/stop-using-print-to-debug-in-python-use-icecream-instead-79e17b963fcc)
  * [Loguru](https://github.com/Delgan/loguru#asynchronous-thread-safe-multiprocess-safe)
  * [dataclasses / attr](https://www.youtube.com/watch?v=vBH6GRJ1REM)
  * [Streamlit](https://streamlit.io/): Streamlit turns data scripts into shareable web apps in minutes. All in Python. All for free. No front‑end experience required.
  * [Pyvis](https://pyvis.readthedocs.io/en/latest/index.html): Interactive network visualizations
  * [NiceGUI](https://pypi.org/project/nicegui/0.2.3/)
  
## Videos

  * [An Introduction to Software Design - With Python](https://www.youtube.com/watch?v=-njsRb8Tn70): Modules, Packages, ...
  * [PyCharm - Scientific Mode](https://www.youtube.com/watch?v=46RjXawJQgg): Effective Data Science with PyCharm
  * [All Top 40 Python Libraries EXPLAINED in 20 minutes](https://www.youtube.com/watch?v=-29x_deQQus)
  * [What Does It Take To Be An Expert At Python?](https://www.youtube.com/watch?v=7lmCu8wz8ro)

## Blogs
  * [miguendes's blog](https://miguendes.me/ )

## Snippets

### Decorators

````python
def my_decorator (p_repeat): # Parameters for the decorator itself
    def outer (func):
        def wrapper(*args, **kwargs): # Parameters for the decorated function
            print("Before")
            for i in range(p_repeat):
                func(*args, **kwargs)
            print("After")

        return wrapper
    return outer

````

### Multiline lambda function

````python
import pandas as pd

df = pd.read_csv("output/edges.csv")

def handle(p_df):
    df = p_df
    new_column_name = 'sources_changed'
    df[new_column_name] = f"new__{df['source']}"
    return df[new_column_name]

df['source_changed'] = df.apply(
                    lambda x: handle(x), axis=1
               )

print("END")
````
