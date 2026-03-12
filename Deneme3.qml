import QtQuick
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick3D
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

    Rectangle {

        id: rectangle
       
        width: 250
        height: 720
        color: "#15232d"
        radius: 15
        border.color: "#2b2222"
        border.width: 14
        bottomLeftRadius: 59
        scale: 1
        topLeftRadius: 31
         FastBlur {
        id: blurLayer
        anchors.fill: parent
        source: rectangle
        radius: 12
    }

    ColumnLayout{
        id: ddeneme3
            anchors.fill: parent
            anchors.leftMargin: 25
            anchors.rightMargin: 15
            anchors.centerIn:parent
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            spacing: 1
            layer.mipmap: false


        FileDialog{
            id: fileDialog
            visible: false
            onAccepted: {

                console.log("User selected:", selectedFile);
                backend.setPath(selectedFile)
            }
            onRejected: {

                console.log("User canceled")
            }
        }
        Button{
            id: fileDialogButton
                text: "Choose Path"

                height: 44
                hoverEnabled: true

                property bool active: false

                onClicked: {
                    active = true
                    fileDialog.open()
                }

                contentItem: Text {
                    text: fileDialogButton.text
                    anchors.centerIn: parent
                    font.family: "Segoe UI"
                    font.pointSize: 13
                    font.weight: Font.DemiBold
                    color: fileDialogButton.active ? "#ffffff" : "#cfd8e3"
                }

                background: Rectangle {
                    id: bg
                    radius: 8

                    color: fileDialogButton.active
                           ? "#3a4756"
                           : fileDialogButton.hovered
                             ? "#2e3945"
                             : "#222a33"

                    border.width: fileDialogButton.active ? 1 : 0
                    border.color: "#5b9cff"

                    Behavior on color {
                        ColorAnimation { duration: 120 }
                    }

                    Behavior on border.width {
                        NumberAnimation { duration: 120 }
                    }
                }

                MultiEffect {
                    anchors.fill: bg
                    source: bg

                    shadowEnabled: true
                    shadowBlur: 0.6
                    shadowVerticalOffset: 2
                    shadowColor: "#55000000"

                    brightness: fileDialogButton.hovered ? 0.05 : 0
                }

        }

        Slider {
            id: rangeSlider
            width: 300
            value: 0.85
            padding: 3
            leftPadding: 3
            topPadding: 3
            orientation: Qt.Horizontal
            live: true
            onValueChanged: { cv.setBlurIntensity( 10*value) }


        }

        Slider {
            id: rangeSlider1
            width: 150
            value: 0.25
            topPadding: 3
            onValueChanged: { cv.setThreshMax( 255*value) }
        }

        Slider {

            id: rangeSlider2
            width: 150
            value: 0.75
            topPadding: 3
            onValueChanged: { cv.setCannyThresh( 50*value) }
        }
        Button {
            id: startButton
            width: 200
            height: 40
            flat: true
            text:"start video"
            contentItem: Text{
                text: startButton.text
                color: startButton.hovered || startButton.pressed ? "#ffffff" : "#cfd8e3"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family:"MyFractionFont"
                font.pointSize: 13
                font.weight: Font.DemiBold
            }

            background: Rectangle {
                id: startBg
                radius: 8
                color: startButton.pressed
                       ? "#3a4756"
                       : startButton.hovered
                         ? "#2e3945"
                         : "#222a33"
                border.width: 1
                border.color: "#5b9cff"
            }

            MultiEffect {
                anchors.fill: startBg
                source: startBg

                shadowEnabled: true
                shadowBlur: 0.7
                shadowVerticalOffset: 2
                shadowColor: "#55000000"

                brightness: startButton.hovered ? 0.05 : 0
                contrast: 1.1
            }

            onClicked: {
                if(timer.running==false){
                    backend.startVideo();
                    startButton.text = "stop video"
                    timer.start();
                    timer.running=true
                } else{
                    backend.startVideo();
                    startButton.text = "start video"
                    timer.stop();
                    timer.running=false
                }
            }
        }

        Button {
            id: previousButon
            width: 200
            height: 40
            flat: true

            contentItem: Text{
                text: "previous process"
                color: previousButon.hovered || previousButon.pressed ? "#ffffff" : "#cfd8e3"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family:"MyFractionFont"
                font.pointSize: 13
                font.weight: Font.DemiBold
            }

            background: Rectangle {
                id: prevBg
                radius: 8
                color: previousButon.pressed
                       ? "#3a4756"
                       : previousButon.hovered
                         ? "#2e3945"
                         : "#222a33"
                border.width: 1
                border.color: "#5b9cff"
            }

            MultiEffect {
                anchors.fill: prevBg
                source: prevBg

                shadowEnabled: true
                shadowBlur: 0.7
                shadowVerticalOffset: 2
                shadowColor: "#55000000"

                brightness: previousButon.hovered ? 0.05 : 0
                contrast: 1.1
            }

            onClicked: {
                backend.setIndex(-1)
            }
        }

        Button {
            id: nextButton
            width: 200
            height: 40
            flat: true

            contentItem: Text{
                text: "next process"
                color: nextButton.hovered || nextButton.pressed ? "#ffffff" : "#cfd8e3"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family:"MyFractionFont"
                font.pointSize: 13
                font.weight: Font.DemiBold
            }

            background: Rectangle {
                id: nextBg
                radius: 8
                color: nextButton.pressed
                       ? "#3a4756"
                       : nextButton.hovered
                         ? "#2e3945"
                         : "#222a33"
                border.width: 1
                border.color: "#5b9cff"
            }

            MultiEffect {
                anchors.fill: nextBg
                source: nextBg

                shadowEnabled: true
                shadowBlur: 0.7
                shadowVerticalOffset: 2
                shadowColor: "#55000000"

                brightness: nextButton.hovered ? 0.05 : 0
                contrast: 1.1
            }

            onClicked: {
                backend.setIndex(1)
            }
        }

    }
    }


