import cv2 as cv


img = cv.imread("./data/test2-1.JPG")
img = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
cv.imshow("Demo", img)
cv.waitKey(0)
for i in range(0, 50):
    edges = cv.Canny(img, i*5, 5+i*5, apertureSize=3)
    cv.imshow("Demo", edges)
    cv.waitKey(0)

