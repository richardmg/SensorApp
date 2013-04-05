import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

    function resetArrows()
    {
        arrowX.angle = 0
        arrowY.angle = 0
        arrowZ.rotation = 0
    }

    Gyroscope {
        id: acc
        active: true
        property variant lastTimeX: 0
        property variant lastTimeY: 0
        property variant lastTimeZ: 0

        onXChanged: {
            var timeDiff = timestamp - lastTimeX
            lastTimeX = timestamp
            var normalized = x * (timeDiff/1000000)
            arrowX.angle += normalized
        }
        onYChanged: {
            var timeDiff = timestamp - lastTimeY
            lastTimeY = timestamp
            var normalized = y * (timeDiff/1000000)
            arrowY.angle -= normalized
        }
        onZChanged: {
            var timeDiff = timestamp - lastTimeZ
            lastTimeZ = timestamp
            var normalized = z * (timeDiff/1000000)
            arrowZ.rotation += normalized
        }
    }

    Column {
        Text { color: "gray"; text: "x: " + acc.x.toFixed(2) }
        Text { color: "gray"; text: "y: " + acc.y.toFixed(2) }
        Text { color: "gray"; text: "z: " + acc.z.toFixed(2) }
        Button {
            text: "Reset"
            onClicked: resetArrows()
        }
    }

    Timer {
        interval: 500
        running: true
        onTriggered: resetArrows()
    }

    Column {
        anchors.centerIn: parent
        Image {
            id: imageX
            source: "qrc:/arrow.png"
            width: sourceSize.width / 2
            height: sourceSize.height / 2
            transform: [
                Translate {
                    y: -imageX.sourceSize.height / 4
                },
                Rotation {
                    id: arrowX
                    axis.x: 1
                    axis.y: 0
                    axis.z: 0
                    angle: 0
                }
            ]
        }

        Image {
            id: imageY
            source: "qrc:/arrow.png"
            width: sourceSize.width / 2
            height: sourceSize.height / 2
            transform: [
                Translate {
                    x: -imageY.sourceSize.height / 4
                    y: -imageY.sourceSize.height / 4
                },
                Rotation {
                    axis.x: 0
                    axis.y: 0
                    axis.z: 1
                    angle: -90
                },
                Rotation {
                    id: arrowY
                    axis.x: 0
                    axis.y: 1
                    axis.z: 0
                    angle: 0
                }
            ]
        }

        Image {
            id: arrowZ
            source: "qrc:/arrow.png"
            width: sourceSize.width / 2
            height: sourceSize.height / 2
            rotation: 0
        }
    }
    
}
