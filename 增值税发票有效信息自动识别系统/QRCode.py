import cv2 as cv
from pyzbar.pyzbar import decode
import numpy as np


def text_create(path, name, list):
    full_path = path + name + '.txt'  # 也可以创建一个.doc的word文档
    file = open(full_path, 'w')
    msg = ""
    msg = msg + "发票代码"
    msg = msg + " " + list[2] + "\n"
    msg = msg + "发票号码"
    msg = msg + " " + list[3] + "\n"
    msg = msg + "开票日期"
    msg = msg + " " + list[5] + "\n"
    msg = msg + "校验码"
    msg = msg + " " + list[6] + "\n"
    msg = msg + "税前价格"
    msg = msg + " " + list[4] + "\n"
    msg = msg + "价税合计"
    msg = msg + " " + list[7] + "\n"
    print(msg)
    file.write(msg)
    file.close()


def QRCode(img):
    listData = []
    for barcode in decode(img):
        myData = barcode.data.decode('utf-8')
        # 添加方框
        pts = np.array([barcode.polygon], np.int32)
        pts = pts.reshape((-1, 1, 2))
        cv.polylines(img, [pts], True, (0, 255, 0), 5)
        listData = myData.split(',')
        # print(listData)
        # cv.imshow("Result", img)
        # cv.waitKey(0)
    return listData

"""
img = cv.imread("example.jpg")
img = cv.resize(img, [1270, 820])
resultList = QRCode(img)
text_create("./result/", "temp", resultList)
"""