import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

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
            normalizedX.angle += normalized
            rotX.angle += normalized * Math.cos((rotZ.angle * Math.PI) / 180)
        }
        onYChanged: {
            var timeDiff = timestamp - lastTimeY
            lastTimeY = timestamp
            var normalized = y * (timeDiff/1000000)
            normalizedY.angle += normalized
            rotX.angle += normalized * -Math.sin((rotZ.angle * Math.PI) / 180)
            rotZ.angle += normalized * Math.sin((rotX.angle * Math.PI) / 180)
        }
        onZChanged: {
            var timeDiff = timestamp - lastTimeZ
            lastTimeZ = timestamp
            var normalized = z * (timeDiff/1000000)
            normalizedZ.angle += normalized
            rotZ.angle += normalized
        }
    }

    Image {
        id: arrow
        source: "qrc:/arrow.png"
        x: ((root.width - width) / 2) + (width / 2)
        y: ((root.height - height) / 2) + (height / 2)
        transform: [
            Translate {
                x: -arrow.width / 2
                y: -arrow.height / 2
            },
            Rotation {
                id: rotX
                axis.x: 1
                axis.y: 0
                axis.z: 0
            },
            Rotation {
                id: rotZ
                axis.x: 0
                axis.y: 0
                axis.z: 1
            },
            Rotation {
                id: rotY
                axis.x: 0
                axis.y: 1
                axis.z: 0
            }
        ]
    }

    Column {
        Text { color: "gray"; text: "x: " + acc.x.toFixed(2) }
        Text { color: "gray"; text: "y: " + acc.y.toFixed(2) }
        Text { color: "gray"; text: "z: " + acc.z.toFixed(2) }
        Button {
            text: "Reset"
            color: "gray"
            onClicked: {
                normalizedX.angle = normalizedY.angle = normalizedZ.angle = 0
                rotX.angle = rotY.angle = rotZ.angle = 0
            }
        }
    }

    Row {
        id:smallArrows
        anchors.horizontalCenter: parent.horizontalCenter
        property int arrowSize: 60
        y: arrowSize
        width: childrenRect.width
        height: arrowSize
        Image {
            width: smallArrows.arrowSize
            height: smallArrows.arrowSize
            source: "qrc:/arrow.png"
            transform: [
                Translate {
                    x: -smallArrows.arrowSize / 2
                    y: -smallArrows.arrowSize / 2
                },
                Rotation {
                    id: normalizedX
                    axis.x: 1
                    axis.y: 0
                    axis.z: 0
                }
            ]
        }
        Image {
            source: "qrc:/arrow.png"
            width: smallArrows.arrowSize
            height: smallArrows.arrowSize
            transform: [
                Translate {
                    x: -smallArrows.arrowSize / 2
                    y: -smallArrows.arrowSize / 2
                },
                Rotation {
                    id: normalizedY
                    axis.x: 0
                    axis.y: 1
                    axis.z: 0
                }
            ]
        }
        Image {
            source: "qrc:/arrow.png"
            width: smallArrows.arrowSize
            height: smallArrows.arrowSize
            transform: [
                Translate {
                    x: -smallArrows.arrowSize / 2
                    y: -smallArrows.arrowSize / 2
                },
                Rotation {
                    id: normalizedZ
                    axis.x: 0
                    axis.y: 0
                    axis.z: 1
                }
            ]
        }
    }
    
}
