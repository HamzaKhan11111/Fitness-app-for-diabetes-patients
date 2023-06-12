from datetime import datetime
import pandas as pd
from json import loads
from time import sleep
import json
import time
from flask import Flask, jsonify, request, render_template,session
from distutils.log import debug
from json import loads
from time import sleep
import pandas as pd
import json
import time
import pickle
from threading import Lock
from flask import Flask, render_template, session

def get_label(label):
    if label == [1]:
        return "Not With User"
    elif label == [2]:
        return "Phone In Use"
    elif label == [3]:
        return "Standing"
    elif label == [4]:
        return "Walking"
    elif label == [5]:
        return "Running"
    else:
        return "Unknown"

app = Flask(__name__)

clf_knn1=pickle.load(open("trained_models/knn_model.pkl","rb") )
clf_dt1=pickle.load(open("trained_models/decision_tree_model.pkl","rb") )
clf_rf1=pickle.load(open("trained_models/random_forest_model.pkl","rb") )
clf_be1=pickle.load(open("trained_models/bagging_ensemble_model.pkl","rb") )


@app.route('/', methods=['POST'])
def sensorRoute():
    global response
    global temp1
 
    request_data = request.data
    request_data = json.loads(request_data.decode( "utf-8"))
    print(request_data)
    temp = [request_data['gposx'],request_data['gposy'],request_data['gposz'],request_data['aposx'],request_data['aposy'],request_data['aposz']]
    m = str(temp)
    # time.sleep(1)
    print("data sent")

    m = m.split(',')
    m[0] = m[0].replace('[', '')
    m[-1] = m[-1].replace(']', '')
    m = [float(i) for i in m[:-1]]
    if(len(m)==5):
        m.append(0.0)

    #creating a dataframe with the values of the sensors (to remove warning)
    df = pd.DataFrame()
    gyroscope=pd.DataFrame()
    accelerometer=pd.DataFrame()
    df['gposx'] = [m[0]]
    df['gposy'] = [m[1]]
    df['gposz'] = [m[2]]
    df['aposx'] = [m[3]]
    df['aposy'] = [m[4]]
    df['aposz'] = [m[5]]

    gyroscope['gposx'] = [m[0]]
    gyroscope['gposy'] = [m[1]]
    gyroscope['gposz'] = [m[2]]
    accelerometer['aposx'] = [m[3]]
    accelerometer['aposy'] = [m[4]]
    accelerometer['aposz'] = [m[5]]



    # df.columns = [['gposx', 'gposy', 'gposz', 'aposx', 'aposy', 'aposz']]

    #predicting labels
    
    knn = get_label(clf_knn1.predict(df))
    dt = get_label(clf_dt1.predict(df))
    rf = get_label(clf_rf1.predict(df))
    be = get_label(clf_be1.predict(df))
    dic={knn:0,dt:0,rf:0,be:0}
    dic[knn]=dic[knn]+1
    dic[dt]=dic[dt]+1
    dic[rf]=dic[rf]+1
    dic[be]=dic[be]+1
    temp=-100
    for k in dic:
        if dic[k] > temp:
            temp =dic[k]
            temp1=k
    print("*****************************")
    print("Knn predicts: ", knn)
    print("Decision Tree predicts: ", dt)
    print("Random Forest predicts: ", rf)
    print("Bagging Ensemble predicts: ", be)
    print("*****************************")
    return ""
        
@app.route('/result', methods=['GET'])
def sensorRoute1():
    # List=[knn,dt,rf,be]
    print (temp1)
    return {"result":temp1}

if __name__ == '__main__':
    app.debug = True
    app.run(host="0.0.0.0",port=5001)