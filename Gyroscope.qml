import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "black"
    anchors.fill: parent

    property real resistance: 25
    property real bounce: 1
    property real accelerationMultiplier: 5

    Accelerometer {
        id: acc
        active: true
        onXChanged: {
            ball.speedX -= (x/accelerationMultiplier) + (ball.speedX/resistance)
            ball.x += ball.speedX
            if (ball.x < 0) {
                ball.x = 0
                ball.speedX = (ball.speedX * -1) / bounce
            }
            if (ball.x > root.width - ball.width) {
                ball.x = root.width - ball.width
                ball.speedX = (ball.speedX * -1) / bounce
            }
        }
        onYChanged: {
            ball.speedY += (y/accelerationMultiplier) - (ball.speedY/resistance)
            ball.y += ball.speedY
            if (ball.y < 0) {
                ball.y = 0
                ball.speedY = (ball.speedY * -1) / bounce
            }
            if (ball.y > root.height - ball.height) {
                ball.y = root.height - ball.height
                ball.speedY = (ball.speedY * -1) / bounce
            }
        }
    }

    Image {
        id: ball
        source: "qrc:/ball.png"
        property real speedX: 0
        property real speedY: 0
        width: 50
        height: 50
        x: (root.width + width)/2
        y: (root.height + height)/2
    }

    Column {
        Text { color: "white"; text: "x: " + acc.x }
        Text { color: "white"; text: "y: " + acc.y }
        Text { color: "white"; text: "z: " + acc.z }
    }

    Row {
        x: 300
        Rectangle {
            width: 50
            height: Math.abs(acc.x * 10)
            color: acc.x > 0 ? "green" : "red"
        }
        Rectangle {
            width: 50
            height: Math.abs(acc.y * 10)
            color: acc.y > 0 ? "green" : "red"
        }
        Rectangle {
            width: 50
            height: Math.abs(acc.z * 10)
            color: acc.z > 0 ? "green" : "red"
        }
    }
    
}
