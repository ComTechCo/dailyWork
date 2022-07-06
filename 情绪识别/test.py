import cv2 as cv
import numpy as np
from keras.preprocessing import image
import pandas as pd
from keras.models import load_model
import warnings

warnings.filterwarnings('ignore')
dataframe = pd.DataFrame(columns=['name', 'label'])
model = load_model("./model/face_classify5.h5")
face_cascade = cv.CascadeClassifier('face_detector.xml')
picRoot = "./data/2.png"
pic = cv.imread(picRoot)

motions = ['angry', 'disgusted', 'fearful', 'happy', 'neutral', 'sad', 'surprised']

faceRange = face_cascade.detectMultiScale(pic, 1.5, 4)
for (x, y, w, h) in faceRange:
    disp = ""
    cv.rectangle(pic, (x, y), (x+w, y+h), (255, 0, 0), 2)
    facePic = pic[y:y+h, x:x+w]
    facePic = cv.resize(facePic, (48, 48))
    #facePic = cv.cvtColor(facePic, cv.COLOR_BGR2GRAY)
    netInput = image.img_to_array(facePic)
    netInput = np.expand_dims(netInput, axis=0)
    faceNp = np.vstack([netInput])
    classes = model.predict(faceNp, batch_size=10)
    num = np.argmax(classes)
    disp = disp + str(motions[num]) + " "
    disp = disp + str(round(classes[0, num]*100, 2)) + "%"
    cv.putText(pic, disp, (round(x), round(y) - 10), cv.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 1)
cv.imshow("demo", pic)
cv.waitKey(0)
