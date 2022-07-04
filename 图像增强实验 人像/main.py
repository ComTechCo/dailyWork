import cv2 as cv
import numpy as np

# 读取图片
man = cv.imread("man.jpg")
backGround = cv.imread("backGround.jpg")
# 读取图片长宽
x, y = man.shape[0:2]
# 调整背景尺寸与头像图片相同
backGround = cv.resize(backGround, (y, x))
h, w, c = man.shape
# 显示原始图片
cv.imshow("task", man)

# 图像锐化增强图片质量
kernel = np.array([[0, -1, 0], [-1, 5, -1], [0, -1, 0]], np.float32)  # 定义卷积核
man = cv.filter2D(man, -1, kernel=kernel)  # 参数：src, depth, kernel

# 中值滤波去噪
man = cv.medianBlur(man, 3)

# 显示并保存提高后的图片
cv.imshow("task", man)
cv.waitKey(0)
cv.imwrite("task3.png", man)
simplenum = h * w

# 将图片转换为点保存
points = np.zeros((simplenum, c), np.float32)
index = 0
for i in range(h):
    for j in range(w):
        index = i * w + j
        points[index][0] = man[i][j][0]
        points[index][1] = man[i][j][1]
        points[index][2] = man[i][j][2]

# 通过k均值聚类完成前后背景分离,即人身分割出来从原图像,属于kmeans中的单特征数据
clusternum = 4
# 终止标准  type, max_iter = 10 , epsilon = 0.1 最大迭代次数与要求的精度
criteria = (cv.TERM_CRITERIA_EPS + cv.TERM_CRITERIA_MAX_ITER, 10, 0.1)
ret, label, center = cv.kmeans(points, clusternum, None, criteria, 10, cv.KMEANS_PP_CENTERS)  # criteria:迭代终止条件
'''
1. ret紧凑度：它是每个点到其相应中心的平方距离的总和。 
2. label标签：这是标签数组，其中每个元素标记为“0”，“ 1” ..... 
3. center中心：这是群集中心的阵列。
'''

# 生产掩模
mask = np.zeros((h, w), np.uint8)
index = w * 2 + 5
dst = man.copy()
new_index = label[index]
for i in range(h):
    for j in range(w):
        index = i * w + j
        label1 = label[index]
        if new_index == label1:
            mask[i][j] = 0
        else:
            mask[i][j] = 255
cv.imshow("task", mask)
cv.waitKey(0)
# 显示原始的风景图片
cv.imshow("task", backGround)
cv.waitKey(0)

# 对风景图片进行高斯滤波 使之边模糊
backGround = cv.GaussianBlur(backGround, (9, 9), 0, 0)
# 显示模糊的风景图
cv.imshow("task", backGround)
cv.waitKey(0)
# 保存模糊的风景图
cv.imwrite("task5.png", backGround)
# 中值滤波去噪声
mask = cv.medianBlur(mask, 5)

# 将人像背景部分变为黑色
for i in range(h):
    for j in range(w):
        if mask[i][j] == 0:
            dst[i][j][0] = 0
            dst[i][j][1] = 0
            dst[i][j][2] = 0
        else:
            continue

# 将人像与风景融合 把人像放入风景
for i in range(h):
    for j in range(w):
        if mask[i][j] == 255:
            backGround[i][j][0] = man[i][j][0]
            backGround[i][j][1] = man[i][j][1]
            backGround[i][j][2] = man[i][j][2]
        else:
            continue
# 中值滤波去噪声
dst = cv.medianBlur(dst, 3)
# 中背景部分置为黑色，人像部分保持不变
cv.imshow("task", dst)
cv.waitKey(0)
cv.imwrite("task4.png", dst)
# 人像图像进行二值化处理，人像部分为0，背景部分为1
cv.imshow("task", mask)
cv.waitKey(0)
cv.imwrite("task6.png", mask)
# 人像迁移
cv.imshow("task", backGround)
cv.waitKey(0)
cv.imwrite("task7.png", backGround)
# 按任意键退出
cv.waitKey(0)
cv.destroyAllWindows()
