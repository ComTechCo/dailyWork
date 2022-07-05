import cv2 as cv
import numpy as np


def line_detection(image):
    # convert the BGR image to HSV colour space
    hsv = cv.cvtColor(image, cv.COLOR_BGR2HSV)
    lower = np.array([0, 10, 250])
    upper = np.array([10, 20, 255])
    mask1 = cv.inRange(hsv, lower, upper)
    lower = np.array([160, 10, 150])
    upper = np.array([180, 60, 255])
    mask2 = cv.inRange(hsv, lower, upper)
    mask = mask1 + mask2
    cv.imshow("Demo", mask)
    cv.waitKey(0)
    img2, dst = cv.threshold(mask, 240, 255, cv.THRESH_BINARY)
    gray = dst
    # apertureSize,Canny边缘检测梯度那一步  apertureSize是sobel算子大小，只能为1,3,5,7
    # 人工给定两个阈值，一个是低阈值TL，一个高阈值TH，
    # 如果边缘像素的梯度值高于高阈值，则将其标记为强边缘像素，该位置的像素值置255；
    # 如果边缘像素的梯度值小于高阈值并且大于低阈值，则将其标记为弱边缘像素；
    # 如果边缘像素的梯度值小于低阈值，则会被抑制，该位置的像素值置0。
    edges = cv.Canny(gray, 30, 150, apertureSize=7)
    lines = cv.HoughLines(edges, 1, np.pi/30, 200) #函数将通过步长为1的半径和步长为π/180的角来搜索所有可能的直线
    lineNumber = 0
    A = 575
    B = 595
    P = 998
    try:
        for line in lines:
            # print(line)
            lineNumber = lineNumber + 1
            rho, theta = line[0] #获取极值ρ长度和θ角度
            if theta == 0 or abs(theta - np.pi/2) < 0.0001:
                a = np.cos(theta) #获取角度cos值
                b = np.sin(theta)#获取角度sin值
                x0 = a * rho #获取x轴值
                y0 = b * rho #获取y轴值　　x0和y0是直线的中点
                x1 = int(x0 + 1000 * (-b)) #获取这条直线最大值点x1
                y1 = int(y0 + 1000 * (a)) #获取这条直线最大值点y1
                x2 = int(x0 - 1000 * (-b)) #获取这条直线最小值点x2
                y2 = int(y0 - 1000 * (a)) #获取这条直线最小值点y2　　其中*1000是内部规则
                #if abs(lastY0 - y0) > 2 or (lastX0 - x0) > 2:
                cv.line(image, (x1, y1), (x2, y2), (0, 0, 255), 1) #开始划线
                #print(lineNumber, x1, y1, x2, y2)
                if lineNumber == 1 and abs(y1-B) < 5:
                    B = y1
                elif lineNumber == 6 and abs(y1-A) < 5:
                    A = y1
                elif abs(x1-998) < 5:
                    P = x1
            """
            cv.imshow("Line", image)
            cv.waitKey(0)
            """
    except TypeError:
        print("NO Line Find")
    return image, A, B, P


"""
for i in range(1, 4):
    src = cv.imread("./data/P"+str(i)+".jpg")
    src = cv.resize(src, [1270, 820])
    img = line_detection(src)
    cv.imshow("Demo", img)
    cv.waitKey(0)
    cv.destroyAllWindows()
"""




