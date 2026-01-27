import Quickshell
import QtQuick

Rectangle {
    color: Theme.colBg
    implicitWidth: clockText.implicitWidth + Theme.modulePaddingX
    radius: 4

    Text {
        id: clockText

        property bool isShort: true
        property string shortFormat: "HH:mm"
        property string longFormat: "dddd • MMMM dd • HH:mm:ss"
        property string currFormat: isShort ? shortFormat : longFormat

        text: Qt.formatDateTime(clock.date, isShort ? shortFormat : longFormat)

        color: Theme.colFg
        anchors.centerIn: parent
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: isShort
    }

    SystemClock {
        id: clock
        precision: clockText.isShort ? SystemClock.Minutes : SystemClock.Seconds
    }

    SequentialAnimation on color {
        running: clock.minutes == 0
        ColorAnimation {
            to: Theme.colBgFlash
            duration: 100
            easing.type: Easing.OutQuad
        }
        ColorAnimation {
            to: Theme.colBg
            duration: 300
            easing.type: Easing.OutQuad
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: clockText.isShort = !clockText.isShort
    }
}
