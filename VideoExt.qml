import QtQuick
import QtQuick.Controls
import QtGraphs

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#282828"
    border.width: 9
    layer.enabled: true
    topLeftRadius: 0

    Rectangle {
        id: graphRect
        x: 1554
        y: 0
        width: 374
        height: 1063
        color: "#262626"
        radius: 1
        border.color: "#999292"
        border.width: 3
        transformOrigin: Item.Center

        GraphsView {
            id: line
            x: 37
            y: 36
            width: 300
            height: 300
            ValueAxis {
                id: valueAxisX1
                min: 0
                max: 10
            }

            ValueAxis {
                id: valueAxisY1
                min: 0
                max: 10
            }

            LineSeries {
                id: lineSeries1
                XYPoint {
                    x: 0
                    y: 2
                }

                XYPoint {
                    x: 3
                    y: 1.2
                }

                XYPoint {
                    x: 7
                    y: 3.3
                }

                XYPoint {
                    x: 10
                    y: 2.1
                }
            }
            axisY: valueAxisY1
            axisX: valueAxisX1
        }
    }

    Rectangle {
        id: bottomRect
        x: 130
        y: 945
        width: 1418
        height: 118
        color: "#262626"
        radius: 1
        border.color: "#999292"
        border.width: 3
        transformOrigin: Item.Center
    }

    Rectangle {
        id: mainImageRect
        x: 130
        y: 148
        width: 1418
        height: 766
        color: "#262626"
        radius: 1
        border.color: "#999292"
        border.width: 3
        transformOrigin: Item.Center

        Image {
            id: image
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 15
            anchors.bottomMargin: 15
            source: "../../../../Downloads/man-posing-indoors-side-view.jpg"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: topRect
        x: 130
        y: 67
        width: 1418
        height: 82
        color: "#262626"
        radius: 1
        border.color: "#999292"
        border.width: 3
        transformOrigin: Item.Center
    }

    Rectangle {
        id: settingsRect
        x: 22
        y: 67
        width: 102
        height: 996
        color: "#282828"
        radius: 1
        border.color: "#999292"
        border.width: 3
    }

    Button {
        id: button
        background:null
        x: 24
        y: 918
        width: 96
        text: qsTr("Button")
        z: 0
        display: AbstractButton.IconOnly
        icon.source: "../../../../Downloads/video_15032517.png"
        highlighted: true
        flat: true
        Behavior on scale { NumberAnimation { duration: 100 } }
        Behavior on opacity { NumberAnimation { duration: 100 } }
        opacity: down ? 0.5 : 1.0

        // Basıldığında hafifçe küçülür (içe çökme hissi verir)
        scale: down ? 0.9 : 1.0
    }

    Button {
        id: button1
        background:null
        x: 23
        y: 970
        width: 96
        text: "Button"
        flat: true
        z: 0
        highlighted: true
        display: AbstractButton.IconOnly
        enabled: true
        icon.source: "../../../../Downloads/stop_6927587.png"
        // 1. ARKA PLANI SİL: O gri dikdörtgenden kurtuluruz

            // 2. TIKLANMA BELİRTECİ (Görsel Efektler):
            // Basıldığında (down) %50 şeffaf olur, normalde tam görünür
            opacity: down ? 0.5 : 1.0

            // Basıldığında hafifçe küçülür (içe çökme hissi verir)
            scale: down ? 0.9 : 1.0

            // Geçişlerin yumuşak olması için animasyon ekleyebilirsin
            Behavior on scale { NumberAnimation { duration: 100 } }
            Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: topRect1
        x: 23
        y: 23
        width: 1525
        height: 38
        color: "#fff9f9"
        radius: 1
        border.color: "#999292"
        border.width: 3
        transformOrigin: Item.Center

        Text {
            id: text1
            x: 16
            y: 11
            text: qsTr("Omer Can Demirci")
            font.pixelSize: 12
        }
    }

    ComboBox {
        id: comboBox
        x: 25
        y: 112
        width: 92
        height: 37
        font.letterSpacing: -1.2
        font.hintingPreference: Font.PreferDefaultHinting
        font.pointSize: 12
        font.bold: false
        font.preferShaping: true
        font.kerning: true
        font.wordSpacing: 0.9
        rightInset: 0
        leftInset: 0
        topInset: 0
        leftPadding: 4
        topPadding: 2
        wheelEnabled: true
        spacing: 0
        editable: false
        flat: false
        currentIndex: 0
        displayText: "Select Output"
        model: ["Option 1", "Option 2", "Option 3"]

    }
}
