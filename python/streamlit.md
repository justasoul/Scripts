## Youtube Videos:
  * [Streamlit - Building Financial Dashboards with Python](https://www.youtube.com/watch?v=0ESc1bh3eIg)
  * [How to Animate Plots on Streamlit, Bring your Plots to Life!](https://www.youtube.com/watch?v=VZ_tS4F6P2A)
  * [Create Data Visualization Web App: File Upload using Streamlit](https://www.youtube.com/watch?v=w2PwerViVbA)

## Debug on pycharm:

https://stackoverflow.com/questions/60172282/how-to-run-debug-a-streamlit-application-from-an-ide

  edit: Just found a way to debug your own scripts. Instead of debugging your script, you debug the streamlit.cli module which runs your script. To do so, you need to change from Script path: to Module name: in the top-most field (there is a slightly hidden dropdown box there...). Then you can insert streamlit.cli into the field. As the parameters, you now add run code.py into the Parameters: field of the Run/Debug Configuration. 

![image](https://i.stack.imgur.com/rePKV.png)
