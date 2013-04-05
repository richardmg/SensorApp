import QtQuick 1.1

Rectangle {
    id: root
    property alias text: label.text
    signal clicked

    width: label.width + 20
    height: label.height + 20
    radius: 4

    color: "lightgray"

    Text {
        id: label
        font.pixelSize: 20
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onPressed: root.clicked()
    }
}
