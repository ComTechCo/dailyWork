import cv2 as cv
import torch
import torchvision as tv
import torchvision.transforms as transforms
import torch.nn as nn
import torch.optim as optim


# 定义AlexNet网络结构
class AlexNet(nn.Module):
    def __init__(self, width_mult=1):
        super(AlexNet, self).__init__()
        self.layer1 = nn.Sequential( # 输入1*28*28
            nn.Conv2d(1, 32, kernel_size=3, padding=1), # 32*28*28
            nn.MaxPool2d(kernel_size=2, stride=2), # 32*14*14
            nn.ReLU(inplace=True),
            )
        self.layer2 = nn.Sequential(
            nn.Conv2d(32, 64, kernel_size=3, padding=1), # 64*14*14
            nn.MaxPool2d(kernel_size=2, stride=2), # 64*7*7
            nn.ReLU(inplace=True),
            )
        self.layer3 = nn.Sequential(
            nn.Conv2d(64, 128, kernel_size=3, padding=1), # 128*7*7
            )
        self.layer4 = nn.Sequential(
            nn.Conv2d(128, 256, kernel_size=3, padding=1), # 256*7*7
            )

        self.layer5 = nn.Sequential(
            nn.Conv2d(256, 256, kernel_size=3, padding=1), # 256*7*7
            nn.MaxPool2d(kernel_size=3, stride=2), # 256*3*3
            nn.ReLU(inplace=True),
            )
        self.fc1 = nn.Linear(256*3*3, 1024)
        self.fc2 = nn.Linear(1024, 512)
        self.fc3 = nn.Linear(512, 10)

    def forward(self, x):
        x = self.layer1(x)
        x = self.layer2(x)
        x = self.layer3(x)
        x = self.layer4(x)
        x = self.layer5(x)
        x = x.view(-1, 256*3*3)
        x = self.fc1(x)
        x = self.fc2(x)
        x = self.fc3(x)
        return x


device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
net = AlexNet().to(device)
net.load_state_dict(torch.load('./params.pth'))


def coutPrice(img, A, B, P):
    price = 0
    set = 3
    allROI = img[A:B, P: P+6*14]
    cv.imshow("Number", cv.resize(allROI, (850, 200)))
    cv.waitKey(0)
    for eachNumber in range(0, 6):
        eachROI = img[A:B, P+14*eachNumber: P+14+14*eachNumber]
        eachROI = cv.resize(eachROI, (280, 280))
        gray = cv.cvtColor(eachROI, cv.COLOR_BGR2GRAY)
        # 最大类间方差法(大津算法)，thresh会被忽略，自动计算一个阈值
        _, dst = cv.threshold(gray, 200, 255, cv.THRESH_BINARY)
        dst = 255 - dst
        eachDst = cv.resize(dst, (28, 28))
        eachDst = torch.from_numpy(eachDst).float()
        eachDst = eachDst.view(1, 1, 28, 28)
        eachDst = eachDst.to(device)
        outputs = net(eachDst)
        _, predicted = torch.max(outputs.data, 1)
        price = price * 10 + predicted.to('cpu').numpy().squeeze()
        cv.imshow("Number", dst)
        # print(dst.sum())
        if dst.sum() < 2000000 or set < 3:
            set = set - 1
        if set == 2:
            print('.')
        else:
            print(predicted.to('cpu').numpy().squeeze())
        cv.waitKey(0)
        if set == 0:
            break
    price = price//1000+price % 100*0.01
    print(price)
    return price




"""
for i in range(1, 5):
    img = cv.imread("./data/P"+str(i)+".jpg")
    img = cv.resize(img, [1270, 820])
    coutPrice(img)
"""
