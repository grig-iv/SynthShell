import Quickshell
import QtQuick
import Quickshell.Services.SystemTray
import QtQuick.Layouts

ColumnLayout {
    spacing: 8

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
