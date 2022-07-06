# -*- coding: utf-8 -*-
import urllib.request
import urllib.error
import time
import json
import cv2 as cv


motions = ["anger", "disgust", "fear", "happiness", "neutral", "sadness", "surprise"]


def genRequre(fileEncode):
    http_url = 'https://api-cn.faceplusplus.com/facepp/v3/detect'
    key = "qbovu8FjTE4mXfULxjwoby-JhznRHVCT"
    secret = "1yhpPlrb8QFCxugR8povKZTtzKAiVlnO"
    boundary = '----------%s' % hex(int(time.time() * 10))
    data = []
    data.append('--%s' % boundary)
    data.append('Content-Disposition: form-data; name="%s"\r\n' % 'api_key')
    data.append(key)
    data.append('--%s' % boundary)
    data.append('Content-Disposition: form-data; name="%s"\r\n' % 'api_secret')
    data.append(secret)
    data.append('--%s' % boundary)
    data.append('Content-Disposition: form-data; name="%s"; filename=" "' % 'image_file')
    data.append('Content-Type: %s\r\n' % 'application/octet-stream')
    data.append(fileEncode)
    data.append('Content-Disposition: form-data; name="%s"; filename=" "' % 'image_file')
    data.append('Content-Type: %s\r\n' % 'application/octet-stream')
    data.append('--%s' % boundary)
    data.append('Content-Disposition: form-data; name="%s"\r\n' % 'return_landmark')
    data.append('1')
    data.append('--%s' % boundary)
    data.append('Content-Disposition: form-data; name="%s"\r\n' % 'return_attributes')
    data.append(
        "gender,headpose,blur,eyestatus,emotion,eyegaze")
    data.append('--%s--\r\n' % boundary)
    for i, d in enumerate(data):
        if isinstance(d, str):
            data[i] = d.encode('utf-8')

    http_body = b'\r\n'.join(data)

    # build http request
    req = urllib.request.Request(url=http_url, data=http_body)

    # header
    req.add_header('Content-Type', 'multipart/form-data; boundary=%s' % boundary)
    return req


def face_plus(pic):
    try:
        _, encodePic = cv.imencode(".jpg", pic)
        resp = urllib.request.urlopen(genRequre(encodePic), timeout=1)
        faceReturn = resp.read().decode('utf-8')
        faceReturnJson = json.loads(faceReturn)
        faceNumber = int(faceReturnJson["face_num"])
        for faceI in range(0, faceNumber):
            print(faceI,faceNumber)
            faceData = faceReturnJson["faces"][faceI]
            faceLocation = faceData["face_rectangle"]
            faceLocationTop = int(faceData["face_rectangle"]["top"])
            faceLocationLeft = int(faceData["face_rectangle"]["left"])
            faceLocationWidth = int(faceData["face_rectangle"]["width"])
            faceLocationHeight = int(faceData["face_rectangle"]["height"])
            cv.rectangle(pic,
                         (faceLocationLeft, faceLocationTop),
                         (faceLocationLeft + faceLocationWidth, faceLocationTop + faceLocationHeight),
                         (0, 0, 0), 2)
            if faceData["attributes"]["glass"]["value"] == "None":
                faceEye = min((float(faceData["attributes"]["eyestatus"]["left_eye_status"]["no_glass_eye_open"]),
                    float(faceData["attributes"]["eyestatus"]["left_eye_status"]["no_glass_eye_open"])))
                #print(faceEye)
            else:
                faceEye = min((float(faceData["attributes"]["eyestatus"]["left_eye_status"]["normal_glass_eye_open"]),
                    float(faceData["attributes"]["eyestatus"]["left_eye_status"]["normal_glass_eye_open"])))
                #print(faceEye)
            #print(faceData["attributes"]["emotion"])
            maxMotionRate = 0
            maxMotionIndex = 0
            for motionI in range(0, 7):
                if float(faceData["attributes"]["emotion"][motions[motionI]]) > maxMotionRate:
                    maxMotionRate = float(faceData["attributes"]["emotion"][motions[motionI]])
                    maxMotionIndex = motionI
            note = "SleepyRate " + str(round(100-faceEye, 2)) + '%'
            note = note + ' ' + motions[maxMotionIndex] + ' ' + str(round(maxMotionRate, 2)) + '%'
            cv.putText(pic, note, (faceLocationLeft, faceLocationTop-10), cv.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 1)
        return pic, note, faceLocationLeft, faceLocationTop
    except urllib.error.HTTPError as e:
        print(e.read().decode('utf-8'))

"""
picRoot = "./data/2.png"
pic = cv.imread(picRoot)

face_plus(encodePic)
"""

cap = cv.VideoCapture("./data/demo1.mp4")
success, frame = cap.read()
frameNumber = 0
_, encodePic = cv.imencode(".jpg", frame)
resp = urllib.request.urlopen(genRequre(encodePic), timeout=1)
faceReturn = resp.read().decode('utf-8')
faceReturnJson = json.loads(faceReturn)
faceNumber = int(faceReturnJson["face_num"])
while success:
    print(frameNumber)
    frameNumber = frameNumber + 1
    success, frame = cap.read()
    if frameNumber % 24 == 1 or frameNumber == 1:
        try:
            _, encodePic = cv.imencode(".jpg", frame)
            resp = urllib.request.urlopen(genRequre(encodePic), timeout= 5)
            faceReturn = resp.read().decode('utf-8')
            faceReturnJson = json.loads(faceReturn)
            faceNumber = int(faceReturnJson["face_num"])
        except urllib.error.HTTPError as e:
            print(e.read().decode('utf-8'))
    for faceI in range(0, faceNumber):
        print(faceI, faceNumber)
        faceData = faceReturnJson["faces"][faceI]
        faceLocation = faceData["face_rectangle"]
        faceLocationTop = int(faceData["face_rectangle"]["top"])
        faceLocationLeft = int(faceData["face_rectangle"]["left"])
        faceLocationWidth = int(faceData["face_rectangle"]["width"])
        faceLocationHeight = int(faceData["face_rectangle"]["height"])
        cv.rectangle(frame,
                     (faceLocationLeft, faceLocationTop),
                     (faceLocationLeft + faceLocationWidth, faceLocationTop + faceLocationHeight),
                     (0, 0, 0), 2)
        if faceData["attributes"]["glass"]["value"] == "None":
            faceEye = min((float(faceData["attributes"]["eyestatus"]["left_eye_status"]["no_glass_eye_open"]),
                float(faceData["attributes"]["eyestatus"]["left_eye_status"]["no_glass_eye_open"])))
            #print(faceEye)
        else:
            faceEye = min((float(faceData["attributes"]["eyestatus"]["left_eye_status"]["normal_glass_eye_open"]),
                float(faceData["attributes"]["eyestatus"]["left_eye_status"]["normal_glass_eye_open"])))
            #print(faceEye)
        #print(faceData["attributes"]["emotion"])
        maxMotionRate = 0
        maxMotionIndex = 0
        for motionI in range(0, 7):
            if float(faceData["attributes"]["emotion"][motions[motionI]]) > maxMotionRate:
                maxMotionRate = float(faceData["attributes"]["emotion"][motions[motionI]])
                maxMotionIndex = motionI
        note = "SleepyRate " + str(round(100-faceEye, 2)) + '%'
        note = note + ' ' + motions[maxMotionIndex] + ' ' + str(round(maxMotionRate, 2)) + '%'
        cv.putText(frame, note, (faceLocationLeft, faceLocationTop-10), cv.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 1)
    cv.imshow("Demo", frame)
    cv.waitKey(120)
cap.release()
cv.destroyAllWindows()
