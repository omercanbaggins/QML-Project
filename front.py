import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import Qt, QRect, QTimer
from PySide6.QtCore import QObject, Slot,QUrl
from PySide6.QtQuick import QQuickImageProvider

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
imageProvider = Qt.Q

QQuickImageProvider()
class backendSide(QObject):

    def __init__(self,QMLfile):
        super().__init__()
        self.QmlPath =QMLfile
        self.timer = QTimer()
        engine.rootContext().setContextProperty("backend", self)
        engine.load(self.QmlPath)

    @Slot()  
    def startVideo(self):
        self.timer.start(30)

backendObj = backendSide("main.qml")

if not engine.rootObjects():
    sys.exit(-1)
sys.exit(app.exec())