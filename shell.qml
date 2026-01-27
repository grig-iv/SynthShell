import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true
    margins.left: 16
    margins.right: 16
    margins.top: 4
    implicitHeight: 26
    color: "transparent"

    RowLayout {
        id: rootLayout

        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            TrayWidget {
                implicitHeight: root.height
            }
        }

        ClockWidget {
            implicitHeight: root.height
        }

        Item {
            Layout.fillWidth: true

            KeyboardWidget {
                implicitHeight: root.height
                anchors.right: audioWidget.left
                anchors.rightMargin: 6
            }

            AudioWidget {
                id: audioWidget
                implicitHeight: root.height
                anchors.right: powerWidget.left
                anchors.rightMargin: 6
            }

            PowerWidget {
                id: powerWidget
                implicitHeight: root.height
            }
        }
    }
}
