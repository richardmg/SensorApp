import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

    Magnetometer {
        id: acc
        active: true
        property variant lastTime: 0
        onXChanged: {
        }
        onYChanged: {
        }
        onZChanged: {
            arrow.rotation = z
        }
    }

    Image {
        id: arrow
        source: "qrc:/arrow.png"
        x: (root.width - width)/2
        y: (root.height - height)/2
    }

    Column {
        Text { color: "gray"; text: "x: " + acc.x.toFixed(2) }
        Text { color: "gray"; text: "y: " + acc.y.toFixed(2) }
        Text { color: "gray"; text: "z: " + acc.z.toFixed(2) }
    }

    Row {
        x: 300
        property real scale: 1
        Rectangle {
            width: 50
            height: Math.abs(acc.x * scale)
            color: acc.x > 0 ? "green" : "red"
        }
        Rectangle {
            width: 50
            height: Math.abs(acc.y * scale)
            color: acc.y > 0 ? "green" : "red"
        }
        Rectangle {
            width: 50
            height: Math.abs(acc.z * scale)
            color: acc.z > 0 ? "green" : "red"
        }
    }
    
}
