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

        implicitWidth: 36
        color: Theme.colBg

        ColumnLayout {
            anchors.fill: parent

            FocusedApp {
                implicitWidth: parent.width - 8
                Layout.alignment: Qt.AlignHCenter
            }

            Item {
                Layout.fillHeight: true

                MouseArea {
                    anchors.left: parent.left
                    implicitWidth: 4
                    implicitHeight: parent.height
                    onClicked: niriGoLeft.running = true
                }

                Process {
                    id: niriGoLeft
                    command: ["niri", "msg", "action", "focus-column-left"]
                }
            }

            Rectangle {
                implicitWidth: tray.width + 8
                implicitHeight: tray.implicitHeight + 12
                Layout.bottomMargin: 8
                Layout.alignment: Qt.AlignHCenter

                radius: 12
                color: Theme.colBgAlt

                TrayWidget {
                    id: tray
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                implicitWidth: parent.width 
                implicitHeight: 1
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 8
                color: Theme.colSeparator
            }

            AudioWidget {
                id: audioWidget
                implicitWidth: root.width
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 8
            }

            KeyboardWidget {
                id: keyboardWidget
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 2
            }

            PowerWidget {
                id: powerWidget
                implicitWidth: root.width
            }
        }

        ClockWidget {
            id: clockWidget
            anchors.centerIn: parent
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

    PanelWindow {
        anchors.right: true
        anchors.top: true
        anchors.bottom: true

        color: "transparent"
        implicitWidth: 4

        MouseArea {
            anchors.fill: parent
            onClicked: niriGoRight.running = true
        }

        Process {
            id: niriGoRight
            command: ["niri", "msg", "action", "focus-column-right"]
        }
    }
}
