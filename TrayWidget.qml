import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    radius: 12
    color: Theme.colBgAlt

    implicitWidth: tray.width + 12

    RowLayout {
        id: tray
        spacing: 8
        anchors.centerIn: parent

        Repeater {
            model: SystemTray.items

            delegate: MouseArea {
                implicitWidth: root.height - 4
                implicitHeight: root.height - 4

                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                IconImage {
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
