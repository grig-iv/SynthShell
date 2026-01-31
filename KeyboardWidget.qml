import Quickshell
import QtQuick

Text {
    id: langText
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSize + 1
    text: NiriService.currKbLayout.includes("US") ? "🇺🇸" : "🇷🇺"
}
