import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Dialogs
import QtGraphs
import Qt5Compat.GraphicalEffects
ApplicationWindow {
    visible: true
    title: "PySide6 QML Birles"
    width:1920
    height:1080
    

    RowLayout{
        anchors.centerIn:parent
        Deneme3{        
}


   
    Timer {
        id : timer
        interval: 30
        running: false
        repeat: true

        onTriggered: {liveImage.source = "image://cv/live?" + Date.now();
        iTopLeft.source ="image://cv/TL?" + Date.now();iBottomLeft.source = "image://cv/BL?" + Date.now();iTopRight.source = "image://cv/TR?" + Date.now();
        iBottomRight.source = "image://cv/BR?" + Date.now();
        }
           //sureyı ekliyor
    }
    ColumnLayout{
        spacing: 35

        

    RowLayout{Rectangle {
        
    anchors.fill: parent
    color: "#141d29"
    border.width:2
    radius:14
    
      // dark grayish-blue, professional
}
        spacing: 15
        ColumnLayout{

            spacing: 65
            
            Image {

                id: iTopLeft
                source: "image://cv/live"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240
            }
        
            Image {
                id: iBottomLeft
                source: "bg1.png"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240
            }
        }

    

        Image {

            id: liveImage               

            source: "bg1.png"
            Layout.preferredWidth: 640
            Layout.preferredHeight: 480
            opacity: 0

            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
            Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
            Behavior on opacity { NumberAnimation { duration: 300 } }

            MouseArea {
            anchors.centerIn:parent

            anchors.fill: parent
            hoverEnabled:true
            onClicked: (mouse) => {
                console.log("Clicked at:", mouse.x, mouse.y, "Button:", mouse.button)
                cv.getRoiQML(mouse.x,mouse.y)
            }
            onEntered: () => {
                console.log("Mouse entered")
                
            }
            onPositionChanged: (mouse) => {
                lineSeries.replace(1,Qt.point(mouse.x,mouse.y))
                slineSeries.append(Qt.point(mouse.x,mouse.y))
            }
        }

            onStatusChanged: {
                if (status === Image.Ready) {
                    opacity = 1
                }
            }
        }
        ColumnLayout{
            spacing: 10
            Image {
                id: iTopRight               

                //source: "image://cv/crop"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240

                Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on opacity { NumberAnimation { duration: 300 } }
                }


            Image {

                id: iBottomRight             

                source: "bg1.png"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240

                Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on opacity { NumberAnimation { duration: 300 } }
            }
        }
    }
        
    RowLayout{


    GraphsView {
        id: line
        width: 300
        height: 300
        ValueAxis {
            id: valueAxisX
            min: 0
            max: 900
        }

        ValueAxis {
            id: valueAxisY
            min: 0
            max: 900
        }

        LineSeries {
            id: lineSeries
            XYPoint {
                x: 0
                y: 0
            }
            XYPoint {
                x: 3
                y: 21
            }
        }
        axisY: valueAxisY
        axisX: valueAxisX
    }

    GraphsView {
        id: spline
        width: 300
        height: 300
        ValueAxis {
            id: svalueAxisX
            min: 0
            max: 1024
        }

        ValueAxis {
            id: svalueAxisY
            min: 0
            max: 1024
        }

        SplineSeries {
            id: slineSeries
            XYPoint {
                x: 0
                y: 0
            }
           
        }
        axisY: svalueAxisY
        axisX: svalueAxisX
    }

    }
    }
    }
}

    
