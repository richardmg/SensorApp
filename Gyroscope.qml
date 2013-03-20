import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "black"
    anchors.fill: parent

    Gyroscope {
        id: acc
        active: true
        property variant lastTime: 0
        onXChanged: {
        }
        onYChanged: {
        }
        onZChanged: {
            var timeDiff = timestamp - lastTime
            lastTime = timestamp
            arrow.rotation += z * (timeDiff/1000000)
        }
    }

    Image {
        id: arrow
        source: "qrc:/arrow.png"
        x: (root.width - width)/2
        y: (root.height - height)/2
    }

    Column {
        Text { color: "white"; text: "x: " + acc.x }
        Text { color: "white"; text: "y: " + acc.y }
        Text { color: "white"; text: "z: " + acc.z }
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
