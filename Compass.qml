import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

    Compass {
        id: compass
        active: true
    }

    Image {
        id: arrow
        source: "qrc:/compass.png"
        anchors.centerIn: parent
        rotation: -compass.azimuth
    }

    Column {
        Text { color: "gray"; text: "azimuth: " + compass.azimuth.toFixed(2) }
        Text { color: "gray"; text: "calibration level: " + compass.calibrationLevel.toFixed(2) }
    }
}
