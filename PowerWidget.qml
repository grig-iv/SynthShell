import Quickshell
import QtQuick
import Quickshell.Io

Rectangle {
    id: powerRect
    color: mouseArea.containsMouse ? Theme.colBgDanger : Theme.colBg
    implicitWidth: implicitHeight
    radius: 4

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }

    Text {
        id: powerMenuText
        color: Theme.colFg
        anchors.centerIn: parent
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize + 1
        text: "󰐥"
    }

    Process {
        id: powerMenu
        command: ["/home/grig/.config/waybar/scripts/power-menu.sh"]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: powerMenu.running = true
    }
}
