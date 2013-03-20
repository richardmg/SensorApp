import QtQuick 1.1
import Sensors 1.0

Rectangle {
    id: root
    color: "white"
    anchors.fill: parent

    property real friction: 0.05
    property real bounce: 0.6
    property real gravity: 0.2

    Magnetometer {
        id: acc
        active: true
        onXChanged: {
            ball.speedX -= x * gravity
            if (ball.speedX > 0)
                ball.speedX = Math.max(0, ball.speedX - friction)
            else
                ball.speedX = Math.min(0, ball.speedX + friction)
            ball.x += ball.speedX

            if (ball.x < 0) {
                ball.x = 0
                ball.speedX = ball.speedX * -1 * bounce
            }
            if (ball.x > root.width - ball.width) {
                ball.x = root.width - ball.width
                ball.speedX = ball.speedX * -1 * bounce
            }
        }
        onYChanged: {
            ball.speedY += y * gravity
            if (ball.speedY > 0)
                ball.speedY = Math.max(0, ball.speedY - friction)
            else
                ball.speedY = Math.min(0, ball.speedY + friction)
            ball.y += ball.speedY

            if (ball.y < 0) {
                ball.y = 0
                ball.speedY = ball.speedY * -1 * bounce
            }
            if (ball.y > root.height - ball.height) {
                ball.y = root.height - ball.height
                ball.speedY = ball.speedY * -1 * bounce
            }
        }
    }

    Image {
        id: ball
        source: "qrc:/ball.png"
        property real speedX: 0
        property real speedY: 0
        width: 100
        height: 100
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
