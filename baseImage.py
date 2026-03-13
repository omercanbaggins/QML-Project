import cv2
import numpy as np
from PySide6.QtCore import QObject, Signal, Slot, Property
from algortihm import CVAlgorithmClass 

class BaseImageClass(QObject):
    imageChanged = Signal()
    metadataChanged = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._image = None
        self._imagePath = ""
        self._imageWidth = 0
        self._imageHeight = 0
        self._imageGrayScale = False
        
        self.algorithm_list = []

    @Property(int, notify=metadataChanged)
    def imageWidth(self): return self._imageWidth

    @Property(int, notify=metadataChanged)
    def imageHeight(self): return self._imageHeight


    @Slot(str)
    def load_image(self, path):
        self._imagePath = path.replace("file://", "")
        self._image = cv2.imread(self._imagePath)
        if self._image is not None:
            self.updateWithHeight()
            self.imageChanged.emit()   ## when image is changed listeners is informed. 
                                     ## I think listen it from qml and other cv algorithm classes

    def updateWidthHeight(self):
        """Updates metadata based on current image state"""
        if self._image is not None:
            self._imageHeight, self._imageWidth = self._image.shape[:2]
            self.metadataChanged.emit() ##send signals listen the delagate. It can be useful keep code clean

    @Slot(int, int, int, int)
    def cropImage(self, x, y, w, h):  ##will be updated
        
        if self._image is not None:
            self._image = self._image[y:y+h, x:x+w]
            self.updateWithHeight()
            self.imageChanged.emit()

    # --- Algorithm Logic ---

    def add_algorithm(self, algo: CVAlgorithmClass):
        self.algorithm_list.append(algo) ##later i will create qml file contains button binds this method

    @Slot()
    def run_all_algorithms(self):
        """runs algotihms"""
        if self._image is None:
            return

        current_working_img = self._image.copy()  ### algorithm classes need source image. Using loop i set their property

        for algo in self.algorithm_list:
            algo.source_image = current_working_img
            algo.run()
