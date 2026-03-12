import QtQuick
import QtQuick.Controls 
import QtQuick.Layouts
import QtQuick.Dialogs
import QtGraphs
import Qt5Compat.GraphicalEffects

Rectangle {
    width: 400
    height: 900

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "bg1.png"
    }

    FastBlur {
        anchors.fill: parent
        source: backgroundImage
        radius: 20
    }

    Rectangle {
        anchors.fill: parent
        color: "#80ffffff"   // transparent white overlay
    }
}