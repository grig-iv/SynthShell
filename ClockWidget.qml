import Quickshell
import QtQuick

Rectangle {
    color: Theme.colBg
    implicitWidth: clock.implicitWidth + Theme.modulePaddingX
    radius: 4

    Text {
        id: clock

        property bool isShort: true
        property string shortFormat: "HH:mm"
        property string longFormat: "dddd • MMMM dd • HH:mm"
        property string currFormat: isShort ? shortFormat : longFormat

        property var now: new Date()
        text: Qt.formatDateTime(now, isShort ? shortFormat : longFormat)

        color: Theme.colFg
        anchors.centerIn: parent
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: isShort

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.now = new Date()
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            clock.isShort = !clock.isShort;
            clock.now = new Date();
        }
    }
}
