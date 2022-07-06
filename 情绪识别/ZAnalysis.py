import os
import tensorflow as tf
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from keras_preprocessing.image import ImageDataGenerator
import numpy as np
from keras.preprocessing import image
import pandas as pd


#gpus = tf.config.experimental.list_physical_devices('GPU')
#tf.config.experimental.set_memory_growth(gpus[0], True)
from keras.models import load_model
model = load_model("./model/face_classify5.h5")

dataframe = pd.DataFrame(columns=['name', 'label'])
os.chdir('./test/')
# test_num = 1
for file_name in os.listdir():
    img = image.load_img(file_name,target_size=(48,48))
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    images = np.vstack([x])
    classes = model.predict(images, batch_size=10)
    num = np.argmax(classes)

    if num == 0:
        face = 'angry'
        print(file_name+ '  ' + face)  # {'angry': 0, 'disgusted': 1, 'fearful': 2, 'happy': 3, 'neutral': 4, 'sad': 5, 'surprised': 6}
    if num == 1:
        face = 'disgusted'
        print(file_name+ '  ' + face)
    if num == 2:
        face = 'fearful'
        print(file_name+ '  ' + face)
    if num == 3:
        face = 'happy'
        print(file_name+ '  ' + face)
    if num == 4:
        face = 'neutral'
        print(file_name+ '  ' + face)
    if num == 5:
        face = 'sad'
        print(file_name+ '  ' + face)
    if num == 6:
        face = 'surprised'
        print(file_name+ '  ' + face)
    dataframe = dataframe.append({'name':file_name,'label':face},ignore_index=True)
    # test_num = test_num + 1
    # if test_num > 10:
    #     break

dataframe.to_csv('submit.csv')