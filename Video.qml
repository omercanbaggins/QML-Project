import QtQuick
import QtQuick.Controls
import QtGraphs
import QtQuick.Layouts

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#282828"
    anchors.fill: parent
    layer.enabled: true

    RowLayout {
        id: mainRow
        anchors.fill: parent
        spacing: 10

        // ------------------------- SETTINGS RECT -------------------------
        Rectangle {
            id: settingsRect
            color: "#282828"
            radius: 1
            border.color: "#999292"
            border.width: 2
            Layout.preferredWidth: 150
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 20

                ComboBox {
                    id: comboBox
                    width: 120
                    font.pointSize: 12
                    currentIndex: 0
                    displayText: "Select Output"
                    model: ["binary", "normal", "circles"]
                    onCurrentIndexChanged: {
        // update the Image source when selection changes
        image.source = "image://cv/" + comboBox.currentText + "?" + Date.now()
    }
                }

                ColumnLayout {
                    width: 124
                    height: 200
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


                    Button {
                        id: buttonStart1
                        width: 100
                        height: 100
                        opacity: down ? 0.5 : 1.0
                        text: ""
                        icon.source: "start.png"
                        display: AbstractButton.IconOnly
                        Behavior {
                            NumberAnimation {
                                duration: 100
                            }
                        }
                        onClicked:{backend.startVideo()
                        timer.start();
                        timer.running=true
                        
                        
                        }
                        background: null
                    }

                    Button {
                        id: buttonStop1
                        width: 100
                        height: 100
                        opacity: down ? 0.5 : 1.0
                        text: ""
                        icon.source: "stop.png"
                        display: AbstractButton.IconOnly
                        Behavior {
                            NumberAnimation {
                                duration: 100
                            }
                        }
                        background: null
                    }
                }
            }
        }

        // ------------------------- MAIN COLUMN -------------------------
        ColumnLayout {
            id: mainColumn
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Rectangle {
                id: topRect
                color: "#262626"
                radius: 1
                border.color: "#999292"
                border.width: 3
                Layout.fillWidth: true
                Layout.preferredHeight: 60

                Text {
                    id: textTitle
                    text: "Omer Can Demirci"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "#ffffff"
                }
            }

            Rectangle {
                id: mainImageRect
                color: "#262626"
                radius: 1
                border.color: "#999292"
                border.width: 2
                Layout.fillWidth: true
                Layout.fillHeight: true

                
                Image {
                    id: image
                    anchors.fill: parent
                    anchors.margins: 10
                    source: "start.png"
                    fillMode: Image.PreserveAspectFit
                    Timer{
                        id:timer
                    running:false
                    repeat:true
                    onTriggered:{

                        image.source = "image://cv/" + comboBox.currentText + "?" + Date.now()
                    }


                }

                }
            }

            Rectangle {
                id: bottomRect
                color: "#262626"
                radius: 1
                border.color: "#999292"
                border.width: 3
                Layout.fillWidth: true
                Layout.preferredHeight: 100
            }
        }

        // ------------------------- GRAPH RECT -------------------------
        Rectangle {
            id: graphRect
            color: "#262626"
            radius: 1
            border.color: "#999292"
            border.width: 3
            Layout.preferredWidth: 360
            Layout.fillHeight: true

            GraphsView {
                id: line
                anchors.fill: parent
                anchors.margins: 10
                scale: 1.0

                ValueAxis { id: valueAxisX1; min: 0; max: 10 }
                ValueAxis { id: valueAxisY1; min: 0; max: 10 }

                LineSeries {
                    id: lineSeries1
                    XYPoint { x: 0; y: 2 }
                    XYPoint { x: 3; y: 1.2 }
                    XYPoint { x: 7; y: 3.3 }
                    XYPoint { x: 10; y: 2.1 }
                }

                axisY: valueAxisY1
                axisX: valueAxisX1
            }
        }
    }
}
