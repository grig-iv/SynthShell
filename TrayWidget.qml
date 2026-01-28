import Quickshell
import QtQuick
import Quickshell.Services.SystemTray

Rectangle {
    color: Theme.colBg
    implicitWidth: trayLayout.width + Theme.modulePaddingX
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
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton

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
