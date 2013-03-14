import QtQuick 1.1

Rectangle {
    id: root
    property alias text: label.text
    signal clicked

    width: label.width + 20
    height: label.height + 20

    color: "green"
    border.width: 2
    
    Text {
        id: label
        font.pixelSize: 20
        anchors.centerIn: parent
    }
    MouseArea {
        //anchors.fill: parent
        width: root.width
        height: root.height
        onPressed: print("PRESS")
        onReleased: print("RELEASE")
    }
}
