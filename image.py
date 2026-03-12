import cv2
import numpy as np
class image:
    def __init__(self,videoPath):
        self.setPath(videoPath)
        self.cvImage = np.ones((900,900,3),np.uint8)
        self.images = []
        self.cannyThresh=50
        self.blurInt=5
        self.threshMax=127
        self.canny = None
    def setPath(self,path):
        self.videopPath = path
        self.cap = cv2.VideoCapture(path)
    def getNumberofVideo(self):
        return self.images.__len__()
    

    def circleDetect(self):
        circles = cv2.HoughCircles(self.canny,cv2.HOUGH_GRADIENT,
    dp=1,
    minDist=2100,
    param1=50,
    param2=25,
    minRadius=5,
    maxRadius=200)
        blank2 = np.zeros_like(self.cvImage,np.uint8)

        if circles is not None:
              ##since output results are float which is not suitable for coordinates,i casted the to int
            circles = np.round(circles) 

            for i in circles[0,:]:
                center = (int(i[0]),int(i[1]))
                radius = int(i[2])
                cv2.circle(blank2,center,radius,(255,255,255),3)
            cv2.imshow("circles",blank2)

  


    def lineDetect(self):
        lines = cv2.HoughLinesP(self.canny,1,np.pi/180,5,lines=None,minLineLength=15,maxLineGap=10)
        blank = np.zeros_like(self.cvImage,np.uint8)
        if lines is not None:
           for line in lines:
               x1,x2,y1,y2 = np.reshape(line[0],4)
               cv2.line(blank,(x1,y1),(x2,y2),(255,255,255),4)
        cv2.imshow(",,",blank)
        
    def getRoi(self,img,pt):
        pts = np.array(pt)
        pts = pts.reshape((4))
        print(pts)
        x1,y1,x2,y2 = pts
        xMin =np.minimum(x1,x2)
        xMax=np.maximum(x1,x2)
        yMin=np.minimum(y1,y2)
        yMax=np.maximum(y1,y2)

        cropped = img[np.int8(yMin):np.int8(yMax),np.int8(xMin):np.int8(xMax)]
        cv2.imshow(",",cropped)
        return cropped
    def processImage(self):
        b,frame = self.cap.read()
        if (b):
            self.cvImage = cv2.resize(frame,(1280,720))
            blurredImage = cv2.GaussianBlur(self.cvImage,(5,5),sigmaX=self.blurInt)
            grayScale = cv2.cvtColor(blurredImage, cv2.COLOR_RGB2GRAY)
            _,thresh = cv2.threshold(grayScale,self.threshMax,255,cv2.THRESH_BINARY)
            cannyImage = cv2.Canny(thresh,self.cannyThresh,50)
            self.canny = cannyImage
            self.images = []
            self.images.append(self.cvImage)
            self.images.append(blurredImage)
            self.images.append(grayScale)
            self.images.append(thresh)
            self.images.append(cannyImage)
            self.lineDetect()
            self.circleDetect()
            return self.cvImage
        else:
            return np.ones((600,600,3),np.uint8)
    

        
