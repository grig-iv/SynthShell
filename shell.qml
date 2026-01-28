import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        id: root

        anchors.left: true
        anchors.top: true
        anchors.bottom: true

        implicitWidth: 32
        color: Theme.colBg

        ColumnLayout {
            anchors.fill: parent

            TrayWidget {
                implicitWidth: root.width
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 8
            }

            ClockWidget {
                id: clockWidget
                implicitWidth: root.width
                anchors.centerIn: parent
            }

            Item {
                Layout.fillHeight: true
            }

            KeyboardWidget {
                id: keyboardWidget
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 8
            }

            PowerWidget {
                id: powerWidget
                implicitWidth: root.width
            }

            //     AudioWidget {
            //         id: audioWidget
            //         implicitWidth: root.width
            //         anchors.right: powerWidget.left
            //         anchors.rightMargin: 6
            //     }
        }
    }

    PanelWindow {
        anchors.top: true
        anchors.left: true
        anchors.right: true

        color: "transparent"
        implicitHeight: 4

        MouseArea {
            anchors.fill: parent
            onClicked: niriGoTop.running = true
        }

        Process {
            id: niriGoTop
            command: ["niri", "msg", "action", "focus-workspace-up"]
        }
    }

    PanelWindow {
        anchors.bottom: true
        anchors.left: true
        anchors.right: true

        color: "transparent"
        implicitHeight: 4

        MouseArea {
            anchors.fill: parent
            onClicked: niriGoDown.running = true
        }

        Process {
            id: niriGoDown
            command: ["niri", "msg", "action", "focus-workspace-down"]
        }
    }
}
