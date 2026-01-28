import Quickshell
import QtQuick

Item {
    implicitHeight: clockText.implicitHeight

    Text {
        id: clockText

        text: Qt.formatDateTime(clock.date, "HH\nmm")

        color: Theme.colFg
        anchors.centerIn: parent
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
