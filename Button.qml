import QtQuick 1.1

Rectangle {
    id: root
    property alias text: label.text
    signal clicked

    width: label.width + 20
    height: label.height + 20

    color: "green"

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
