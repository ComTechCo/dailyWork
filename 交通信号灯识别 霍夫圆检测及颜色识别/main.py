import cv2
import numpy as np
vc = cv2.VideoCapture("./video.mp4")

if vc.isOpened():
    open,captured_frame = vc.read()
else:
    open = False

while open:
    ret ,captured_frame = vc.read()
    captured_frame1 = cv2.resize(captured_frame, (980, 562))
    if captured_frame is None:
        break
    if ret == True:
        image_medianBlur = cv2.medianBlur(captured_frame1, 5)
        hsv = cv2.cvtColor(image_medianBlur,cv2.COLOR_BGR2HSV)
        # 定义红色阈值
        red_lower = np.array([0, 85, 85])
        red_upper = np.array([10, 255, 255])
        Upper_red_lower = np.array([170 - 10, 85, 85])
        Upper_red_upper = np.array([170 + 10, 255, 255])
        red_mask = cv2.inRange(hsv, red_lower, red_upper)
        upper_red_mask = cv2.inRange(hsv, Upper_red_lower, Upper_red_upper)
        red_final_maskr = cv2.add(red_mask, upper_red_mask)
        red_res = cv2.bitwise_and(image_medianBlur, image_medianBlur, mask=red_final_maskr)
        # 定义绿色阈值
        green_lower = np.array([35, 43, 46])
        green_upper = np.array([97, 255, 255])
        green_mask = cv2.inRange(hsv, green_lower, green_upper)
        green_res = cv2.bitwise_and(image_medianBlur, image_medianBlur, mask=green_mask)
        image = green_res+red_res
        # cv2.imshow('result',image_medianBlur)
        cv2.imshow('out',image)
        if cv2.waitKey(30) & 0xFF == 27:
            break

vc.release()
cv2.destroyAllWindows()