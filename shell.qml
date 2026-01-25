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
                anchors.right: powerWidget.left
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

            PowerWidget {
                id: powerWidget
                implicitHeight: root.height
            }
        }
    }
}
