import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    spacing: 0

    readonly property PwNode node: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [node]
    }

    Text {
        text: getIcon()
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize + 2
        color: Theme.colFgAlt
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: - 2
    }

    Text {
        text: Math.floor(node.audio.volume * 100)
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize - 6
        color: Theme.colFgAlt
        Layout.alignment: Qt.AlignHCenter
    }

    MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
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

    // Connections {
    //     target: node.audio
    //     function volumeChanged() {
    //         flashAnim.restart();
    //     }
    //     function mutedChanged() {
    //         flashAnim.restart();
    //     }
    // }
    //
    // SequentialAnimation on color {
    //     id: flashAnim
    //     ColorAnimation {
    //         to: Theme.colBgFlash
    //         duration: 100
    //         easing.type: Easing.OutQuad
    //     }
    //     ColorAnimation {
    //         to: Theme.colBg
    //         duration: 300
    //         easing.type: Easing.OutQuad
    //     }
    // }

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
