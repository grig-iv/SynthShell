import QtQuick
import Quickshell

Popup {
    id: myPopup
    popupWidth: 300
    popupHeight: 200

    content: Component {
        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Text {
                text: "Popup Menu"
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }

            Rectangle {
                width: parent.width - 20
                height: 1
                color: "#444"
            }

            Repeater {
                model: ["Option 1", "Option 2", "Option 3"]

                Rectangle {
                    width: parent.width - 20
                    height: 30
                    color: ma.containsMouse ? "#3e3e3e" : "transparent"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: "white"
                    }

                    MouseArea {
                        id: ma
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            console.log("Clicked:", modelData);
                            myPopup.close();
                        }
                    }
                }
            }
        }
    }
}
