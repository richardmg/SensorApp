import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: mainWindow
    color: "black"
    Loader {
        id: loader
        width: mainWindow.width
        height: mainWindow.height
        anchors.top: mainWindow.top
        anchors.bottom: buttonRow.top
        anchors.bottomMargin: 2
        source: "qrc:/Accelerometer.qml"
    }
    Row {
        id: buttonRow
        width: mainWindow.width
        height: 50
        x: 2
        spacing: 2
        anchors.bottom: mainWindow.bottom

        Button {
            text: "Accelerometer"
            onClicked: loader.source = "qrc:/Accelerometer.qml"
        }
        Button {
            text: "Gyroscope"
            onClicked: loader.source = "qrc:/Gyroscope.qml"
        }
        Button {
            text: "Magnetometer"
            onClicked: loader.source = "qrc:/Magnetometer.qml"
        }
        Button {
            text: "Compass"
            onClicked: loader.source = "qrc:/Compass.qml"
        }
        Button {
            text: "Proximity"
            onClicked: loader.source = "qrc:/Proximity.qml"
        }
        Button {
            text: "Tilt"
            onClicked: loader.source = "qrc:/TiltSensor.qml"
        }
    }
}
