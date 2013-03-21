import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

    Magnetometer {
        id: mag
        active: true
        onXChanged: {
        }
        onYChanged: {
        }
        onZChanged: {
            arrow.rotation = z/1000000
        }
    }

    Image {
        id: arrow
        source: "qrc:/arrow.png"
        x: (root.width - width)/2
        y: (root.height - height)/2
    }

    Column {
        Text { color: "gray"; text: "x: " + mag.x.toFixed(2) }
        Text { color: "gray"; text: "y: " + mag.y.toFixed(2) }
        Text { color: "gray"; text: "z: " + mag.z.toFixed(2) }
    }

    Row {
        x: 300
        property real scale: 1
        Rectangle {
            width: 50
            height: Math.abs(mag.x * scale)
            color: mag.x > 0 ? "green" : "red"
        }
        Rectangle {
            width: 50
            height: Math.abs(mag.y * scale)
            color: mag.y > 0 ? "green" : "red"
        }
        Rectangle {
            width: 50
            height: Math.abs(mag.z * scale)
            color: mag.z > 0 ? "green" : "red"
        }
    }
    
}
