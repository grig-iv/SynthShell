import Quickshell
import QtQuick

Rectangle {
    id: flagRect
    color: Theme.colBg
    implicitWidth: langText.width + Theme.modulePaddingX
    anchors.verticalCenter: parent.verticalCenter
    radius: 4

    Text {
        id: langText
        anchors.centerIn: parent
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize + 1
        text: NiriService.currKbLayout.includes("US") ? "🇺🇸" : "🇷🇺"
    }
}
