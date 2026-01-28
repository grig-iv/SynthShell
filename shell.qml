import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
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
        id: root

        anchors.top: true
        anchors.left: true
        anchors.right: true
        margins.left: 20
        margins.right: 20
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
