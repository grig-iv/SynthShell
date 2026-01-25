import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.SystemTray

Scope {

    PanelWindow {
        id: root

        // Theme
        property string fontFamily: "JetbrainsMono Nerd Font"
        property int fontSize: 15
        property int modulePaddingX: 12

        property color colBg: "#313244"
        property color colFg: "#cdd6f4"
        property color colDangerBg: "#BD1847"

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
                    color: root.colBg
                    implicitWidth: trayLayout.width + root.modulePaddingX
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

            Rectangle {
                color: root.colBg
                implicitWidth: clock.implicitWidth + root.modulePaddingX
                implicitHeight: root.height
                radius: 4

                Text {
                    id: clock

                    property bool isShort: true
                    property string shortFormat: "HH:mm"
                    property string longFormat: "dddd • MMMM dd • HH:mm"
                    property string currFormat: isShort ? shortFormat : longFormat

                    property var now: new Date()
                    text: Qt.formatDateTime(now, isShort ? shortFormat : longFormat)

                    color: root.colFg
                    anchors.centerIn: parent
                    font.family: root.fontFamily
                    font.pixelSize: root.fontSize
                    font.bold: isShort

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clock.now = new Date()
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        clock.isShort = !clock.isShort;
                        clock.now = new Date();
                    }
                }
            }

            Item {
                Layout.fillWidth: true

                Rectangle {
                    id: flagRect
                    color: root.colBg
                    implicitWidth: langText.width + root.modulePaddingX
                    implicitHeight: root.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: powerRect.left
                    anchors.rightMargin: 6
                    radius: 4

                    Text {
                        id: langText
                        anchors.centerIn: parent
                        font.family: root.fontFamily
                        font.pixelSize: root.fontSize + 1
                        text: NiriService.currKbLayout.includes("US") ? "🇺🇸" : "🇷🇺"
                    }
                }

                Rectangle {
                    id: powerRect
                    color: mouseArea.containsMouse ? root.colDangerBg : root.colBg
                    implicitWidth: root.height
                    implicitHeight: root.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    radius: 4

                    Text {
                        id: powerMenuText
                        color: root.colFg
                        anchors.centerIn: parent
                        font.family: root.fontFamily
                        font.pixelSize: root.fontSize + 1
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
}
