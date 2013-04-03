import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent
    property real compassRotation: 0

    function updateCompass()
    {
        var dx = mag.microtesla.x
        var dy = mag.microtesla.y
        var dz = mag.microtesla.z
        //length = Math.sqrt((dx * dx) + (dy * dy))
        compassRotation = (Math.atan2(mag.x, mag.y) / Math.PI) * 180
    }

    Magnetometer {
        id: mag
        property variant microtesla: {
            x: mag.x * 1000000,
            y: mag.y * 1000000,
            z: mag.z * 1000000
        }

        active: true
        onXChanged: updateCompass()
        onYChanged: updateCompass()
    }

    Image {
        id: arrow
        source: "qrc:/arrow.png"
        x: (root.width - width)/2
        y: (root.height - height)/2
        rotation: compassRotation
    }

    Column {
        Text { color: "gray"; text: "x: " + mag.microtesla.x.toFixed(2) }
        Text { color: "gray"; text: "y: " + mag.microtesla.y.toFixed(2) }
        Text { color: "gray"; text: "z: " + mag.microtesla.z.toFixed(2) }
        Text { color: "gray"; text: "compassRotation: " + compassRotation }
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
