import Quickshell
import QtQuick

Item {
    required property PanelWindow rootWindow

    Text {
        id: clockText

        property bool isShort: true
        readonly property string shortFormat: "HH:mm"
        readonly property string longFormat: "dddd • MMMM dd • HH:mm:ss"

        text: Qt.formatDateTime(clock.date, isShort ? shortFormat : longFormat)

        color: Theme.colFg
        anchors.centerIn: parent
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: isShort

        SequentialAnimation on color {
            running: clock.isShort & clock.minutes == 0
            ColorAnimation {
                to: Theme.colFgFlash
                duration: 100
                easing.type: Easing.OutQuad
            }
            ColorAnimation {
                to: Theme.colFg
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    }

    SystemClock {
        id: clock
        precision: clockText.isShort ? SystemClock.Minutes : SystemClock.Seconds
    }

    MouseArea {
        anchors.fill: clockText
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                PopupService.clockPopup.open();
            } else if (mouse.button === Qt.RightButton) {
                clockText.isShort = !clockText.isShort;
            }
        }
    }
}
