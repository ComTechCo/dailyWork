import cv2 as cv


def delPic(originImg, img, p1, p2, minR, maxR):
    # originImg: 原始图像 将会在这个图像上返回检测到到圆
    # img: 颜色过滤后的图像
    # param1:此参数是对应Canny边缘检测的最大阈值，最小阈值是此参数的一半 也就是说像素的值大于param1是会检测为边缘
    # param2:它表示在检测阶段圆心的累加器阈值。它越小的话，就可以检测到更多根本不存在的圆，而它越大的话，能通过检测的圆就更加接近完美的圆形了
    gray = cv.cvtColor(img, cv.COLOR_RGB2GRAY)
    circles = cv.HoughCircles(gray, cv.HOUGH_GRADIENT, 1, 100, param1=p1, param2=p2, minRadius=minR, maxRadius=maxR)
    #输出检测到圆的个数
    try:
        print("检测到符合要求到圆")
    except TypeError:
        print("没有符合要求的圆")
        return None
    #根据检测到圆的信息，画出每一个圆
    for circle in circles[0]:
        #圆的基本信息
        print(circle[2])
        #坐标行列
        x = int(circle[0])
        y = int(circle[1])
        #半径
        r = int(circle[2])
        #在原图用指定颜色标记出圆的位置
        originImg = cv.circle(originImg, (x, y), r, (0, 0, 255))
    return originImg
