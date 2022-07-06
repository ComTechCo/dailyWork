import cv2
import HoughCircles

#载入并显示图片

#img, p1, p2, minR, maxR
for i in range(17, 40):
    img = cv2.imread('./data/test1.jpg')
    imgLength, imgWidth, _ = img.shape
    print("i=",i)
    img = cv2.resize(img, (826, int(imgLength / imgWidth * 826)))
    img = HoughCircles.delPic(img, 230, 20, 5, 35)
    cv2.imshow('res', img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

"""
For test2
img = HoughCircles.delPic(img, 135, 28, 10, 30)
img = HoughCircles.delPic(img, 135, 28, 100, 110)
img = HoughCircles.delPic(img, 135, 28, 580, 590)
For test3
img = cv2.resize(img, (750, int(imgLength / imgWidth * 750)))
img = HoughCircles.delPic(img, 200, 21, 8, 13)
img = HoughCircles.delPic(img, 200, 13, 8, 13)
"""