## Debug on pycharm:

https://stackoverflow.com/questions/60172282/how-to-run-debug-a-streamlit-application-from-an-ide

  edit: Just found a way to debug your own scripts. Instead of debugging your script, you debug the streamlit.cli module which runs your script. To do so, you need to change from Script path: to Module name: in the top-most field (there is a slightly hidden dropdown box there...). Then you can insert streamlit.cli into the field. As the parameters, you now add run code.py into the Parameters: field of the Run/Debug Configuration. 

![image](https://i.stack.imgur.com/rePKV.png)
