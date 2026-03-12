from PySide6.QtCore import QObject, Slot,QUrlclass 
import time

class ValueTrack(QObject):
    def __init__(self,name,startValue):
        super().__init__(name)
        self.startValue = startValue
        self.lastValue  = startValue
        self.currentValue = startValue
        self.lastCalTime = time.time()
        self.changeOverTime = 0
        
    @Slot(float)
    def calcDiff(self,value):
        dx =diff = value-self.lastValue
        dt =time.time()-self.lastCalTime
        return dx/dt
    def setCurrentLast(self,value):
        self.lastValue = self.currentValue
        self.currentValue = value