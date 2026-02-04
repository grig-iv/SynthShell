import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        id: root

        anchors.top: true
        anchors.left: true
        anchors.right: true
        implicitHeight: 26

        color: Theme.colBg

        RowLayout {
            id: rootLayout
            anchors.fill: parent

            TrayWidget {
                implicitHeight: parent.height - 6
                Layout.leftMargin: 6
                Layout.alignment: Qt.AlignVCenter
            }

            Item {
                Layout.fillWidth: true
            }

            KeyboardWidget {
                height: parent.height
                Layout.rightMargin: 12
            }

            AudioWidget {
                id: audioWidget
                implicitHeight: parent.height
            }

            PowerWidget {
                id: powerWidget
                implicitHeight: parent.height
            }
        }

        ClockWidget {
            implicitHeight: parent.height
            anchors.centerIn: parent
            rootWindow: root
        }

        MouseArea {
            anchors.top: parent.top
            implicitWidth: parent.width
            implicitHeight: 4
            onClicked: modal.open()
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

    ClockPopup {
        id: clockPopup
        Component.onCompleted: {
            PopupService.clockPopup = clockPopup;
        }
    }
}
