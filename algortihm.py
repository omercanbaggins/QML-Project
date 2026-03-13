import cv2
import numpy as np
from abc import ABC, abstractmethod

class CVAlgorithmClass(ABC):
    """ The Base Class (The 'Contract') """
    def __init__(self,image):
        self.source_image = image
        self.output_image = None

    def check_image_exists(self) -> bool:
        return self.source_image is not None

    @abstractmethod
    def run(self):
        """ Every child MUST implement this """
        pass

# --- Inheritance Hierarchy ---

class ThresholdingClass(CVAlgorithmClass):
    def __init__(self,image=None):
        super().__init__(image)
        self.thresh_max = 255
        self.thresh_type = cv2.THRESH_BINARY
        self.thresh_min_value = 127

    def run(self):
        if not self.check_image_exists():
            return
        
        gray = cv2.cvtColor(self.source_image, cv2.COLOR_BGR2GRAY)
        _, self.output_image = cv2.threshold(
            gray, self.thresh_min_value, self.thresh_max, self.thresh_type
        )


class CannyEdgeClass(CVAlgorithmClass):
    def __init__(self,image):
        super().__init__(image)
        self.kernel_matrice = (3, 3)
        self.thresh = 100

    def run(self):
        if not self.check_image_exists():
            return
        
        # Blur before Canny is industry standard to reduce noise
        blurred = cv2.GaussianBlur(self.source_image, self.kernel_matrice, 0)
        self.output_image = cv2.Canny(blurred, self.thresh, self.thresh * 2)

class HoughLineClass(CVAlgorithmClass):
    def __init__(self,image):
        super().__init__(image)
        self.line_min = 100
        self.max_gap = 10
        self.method = "PROBABILISTIC"

    def run(self):
        # Your UML calls this 'find', but to keep the hierarchy 
        # polymorphic, we call it inside run()
        self.find()

    def find(self):
        if not self.check_image_exists():
            return
            
        # Standard Hough Line boilerplate
        gray = cv2.cvtColor(self.source_image, cv2.COLOR_BGR2GRAY)
        edges = cv2.Canny(gray, 50, 150)
        lines = cv2.HoughLinesP(edges, 1, np.pi/180, self.line_min, 
                                minLineLength=self.line_min, maxLineGap=self.max_gap)
        
        # Create a copy to draw lines on
        self.output_image = self.source_image.copy()
        if lines is not None:
            for line in lines:
                x1, y1, x2, y2 = line[0]
                cv2.line(self.output_image, (x1, y1), (x2, y2), (0, 255, 0), 2)
thresh = ThresholdingClass()
cap =cv2.VideoCapture("ue5footage.mp4")
while(True):
    b, frame = cap.read()
    thresh.source_image = frame
    thresh.run()
    cv2.imshow(",",thresh.output_image)
    cv2.waitKey(10)