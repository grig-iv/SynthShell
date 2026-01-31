import Quickshell
import QtQuick

Text {
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSize
    text: NiriService.currKbLayout.includes("US") ? "🇺🇸" : "🇷🇺"
}
