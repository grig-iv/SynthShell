import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    implicitWidth: text.implicitWidth

    readonly property PwNode node: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [node]
    }

    Text {
        id: text
        text: `${getIcon()} ${Math.floor(node.audio.volume * 100)}%`
        anchors.centerIn: parent
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize - 1
        color: Theme.colFg

        SequentialAnimation on color {
            id: flashAnim
            ColorAnimation {
                to: Theme.colFgFlash
                duration: 100
                easing.type: Easing.OutQuad
            }
            ColorAnimation {
                to: Theme.colFg
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                audioSinkCycle.running = true;
            } else if (mouse.button === Qt.RightButton) {
                pavucontrol.running = true;
            }
        }

        Process {
            id: audioSinkCycle
            command: ["audio-sink-cycle"]
        }

        Process {
            id: pavucontrol
            command: ["pavucontrol"]
        }
    }

    Connections {
        target: node.audio
        function onVolumeChanged() {
            flashAnim.restart();
        }
        function onMutedChanged() {
            flashAnim.restart();
        }
    }

    function getIcon() {
        if (node == null)
            return "";

        if (node.name == "alsa_output.pci-0000_c4_00.6.analog-stereo") {
            return node.audio.muted ? "󰓄" : "󰓃";
        }

        if (node.name == "alsa_output.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo") {
            return node.audio.muted ? "󰟎" : "󰋋";
        }

        return node.audio.muted ? "" : "";
    }
}
