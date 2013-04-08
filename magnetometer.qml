import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent
    property real arraowRotation: 0

    function updatearrow()
    {
        arraowRotation = ((Math.atan2(mag.x, mag.y) / Math.PI) * 180)
    }

    Magnetometer {
        id: mag
        property variant microtesla: {
            x: mag.x * 1000000,
            y: mag.y * 1000000,
            z: mag.z * 1000000
        }

        returnGeoValues: false
        active: true
        onXChanged: updatearrow()
        onYChanged: updatearrow()
    }

    Image {
        id: arrow
        source: "qrc:/magnet.png"
        x: (root.width - width)/2
        y: (root.height - height)/2
        rotation: arraowRotation
    }

    Column {
        Text { color: "gray"; text: "x: " + mag.microtesla.x.toFixed(2) }
        Text { color: "gray"; text: "y: " + mag.microtesla.y.toFixed(2) }
        Text { color: "gray"; text: "z: " + mag.microtesla.z.toFixed(2) }
        Text { color: "gray"; text: "r: " + arraowRotation.toFixed(2) }
        Button {
            text: mag.returnGeoValues ? "Use raw values" : "Use geo calibrated values"
            onClicked: mag.returnGeoValues = !mag.returnGeoValues
        }
    }
}
