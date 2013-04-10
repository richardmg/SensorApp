import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

    TiltSensor {
        id: tilt
        active: true
    }

    Item {
        id: grid
        width: childrenRect.width
        height: childrenRect.height
        x: (root.width)/2
        y: (root.height)/2

        Column {
            Repeater {
                model: 20
                delegate: Row {
                    Repeater {
                        model: 20
                        delegate: Rectangle {
                            width: 20
                            height: 20
                            color: "white"
                            border.width: 2
                            border.color: "blue"
                        }
                    }
                }
            }
        }
        transform: [
            Translate {
                x: -grid.width / 2
                y: -grid.height / 2
            },
            Rotation {
                axis.x: 1
                axis.y: 0
                axis.z: 0
                angle: tilt.x
            },
            Rotation {
                axis.x: 0
                axis.y: 1
                axis.z: 0
                angle: -tilt.y
            }
        ]
    }

    Column {
        Text { color: "gray"; text: "xRotation: " + tilt.x.toFixed(2) }
        Text { color: "gray"; text: "yRotation: " + tilt.y.toFixed(2) }
    }
}
