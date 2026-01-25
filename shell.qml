import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 26
    margins.left: 16
    margins.right: 16
    margins.top: 4
    color: "transparent"

    RowLayout {
        id: rootLayout

        anchors.fill: parent

        Item {
            Layout.fillWidth: true

            Rectangle {
                color: Theme.colBg
                implicitWidth: trayLayout.width + Theme.modulePaddingX
                implicitHeight: root.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                radius: 4

                Row {
                    id: trayLayout
                    spacing: 8
                    anchors.centerIn: parent

                    Repeater {
                        model: SystemTray.items

                        delegate: MouseArea {
                            implicitWidth: 16
                            implicitHeight: 16

                            Image {
                                anchors.fill: parent
                                source: modelData.icon
                            }

                            onClicked: mouse => {
                                if (mouse.button === Qt.LeftButton) {
                                    modelData.activate();
                                } else if (mouse.button === Qt.RightButton) {
                                    modelData.display(root, 0, 0);
                                }
                            }
                        }
                    }
                }
            }
        }

        ClockWidget {
            implicitHeight: root.height
        }

        Item {
            Layout.fillWidth: true

            Rectangle {
                id: flagRect
                color: Theme.colBg
                implicitWidth: langText.width + Theme.modulePaddingX
                implicitHeight: root.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: powerRect.left
                anchors.rightMargin: 6
                radius: 4

                Text {
                    id: langText
                    anchors.centerIn: parent
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize + 1
                    text: NiriService.currKbLayout.includes("US") ? "🇺🇸" : "🇷🇺"
                }
            }

            Rectangle {
                id: powerRect
                color: mouseArea.containsMouse ? Theme.colDangerBg : Theme.colBg
                implicitWidth: root.height
                implicitHeight: root.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                radius: 4

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Text {
                    id: powerMenuText
                    color: Theme.colFg
                    anchors.centerIn: parent
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize + 1
                    text: "󰐥"
                }

                Process {
                    id: powerMenu
                    command: ["/home/grig/.config/waybar/scripts/power-menu.sh"]
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: powerMenu.running = true
                }
            }
        }
    }
}
