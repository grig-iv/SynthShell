import Quickshell
import QtQuick

Text {
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSize + 1
    text: NiriService.currKbLayout.includes("US") ? "🇺🇸" : "🇷🇺"
}
