import Quickshell
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 0

    Text {
        id: hours

        text: Qt.formatDateTime(clock.date, "HH")

        color: Theme.colFg
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
    }

    Text {
        text: "--"
        Layout.bottomMargin: -8
        Layout.topMargin: -8
        Layout.alignment: Qt.AlignHCenter
        color: Theme.colFgAlt
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }

    Text {
        id: minutes

        text: Qt.formatDateTime(clock.date, "mm")

        color: Theme.colFg
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
