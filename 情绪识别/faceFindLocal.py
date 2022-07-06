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

cap = cv.VideoCapture("./data/demo1.mp4")
# cap = cv.VideoCapture(0)
# 对OpenCV人脸检测方法detectMultiScale参数“最直白”的理解——Python学习笔记（8）


motions = ['angry', 'disgusted', 'fearful', 'happy', 'neutral', 'sad', 'surprised']

face_cascade = cv.CascadeClassifier('face_detector.xml')
success, frame = cap.read()
frameNumber = 0

while success:
    print(frameNumber)
    frameNumber = frameNumber + 1
    face = face_cascade.detectMultiScale(frame, 1.1, 6)
    for (x, y, w, h) in face:
        disp = ""
        cv.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), 2)
        facePic = frame[y:y + h, x:x + w]
        facePic = cv.resize(facePic, (48, 48))
        # facePic = cv.cvtColor(facePic, cv.COLOR_BGR2GRAY)
        netInput = image.img_to_array(facePic)
        netInput = np.expand_dims(netInput, axis=0)
        faceNp = np.vstack([netInput])
        classes = model.predict(faceNp, batch_size=10)
        num = np.argmax(classes)
        disp = disp + str(motions[num+1]) + " "
        disp = disp + str(round(classes[0, num] * 100, 2)) + "%"
        cv.putText(frame, disp, (round(x), round(y) - 10), cv.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 1)
    cv.imshow("Demo", frame)
    cv.waitKey(60)
    success, frame = cap.read()
cap.release()
cv.destroyAllWindows()
