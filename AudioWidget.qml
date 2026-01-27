import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Rectangle {
    color: Theme.colBg
    implicitWidth: text.implicitWidth + Theme.modulePaddingX + 4
    anchors.verticalCenter: parent.verticalCenter
    radius: 4

    property PwNode node: Pipewire.defaultAudioSink
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
    }

    function getIcon() {
        if (node.name == "alsa_output.pci-0000_c4_00.6.analog-stereo") {
            return node.audio.muted ? "󰓄" : "󰓃";
        }

        if (node.name == "alsa_output.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo") {
            return node.audio.muted ? "󰟎" : "󰋋";
        }

        return node.audio.muted ? "" : "";
    }
}
