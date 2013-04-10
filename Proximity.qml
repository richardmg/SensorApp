import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

    ProximitySensor {
        id: sensor
        active: true
    }

    Text {
        visible: !sensor.available
        anchors.fill: parent
        font.pointSize: 80
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        color: "green"
        text: "Proximity sensor is not available on this device!"
    }

    Text {
        visible: sensor.available
        anchors.fill: parent
        font.pointSize: 80
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        color: sensor.close ? "red" : "green"
        text: "Are you close to device? " + (sensor.close  ? "Yes" : "No")
    }
}
