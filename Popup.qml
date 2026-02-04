import QtQuick
import Quickshell
import Quickshell.Wayland

Item {
    id: root

    property alias content: contentLoader.sourceComponent
    property real popupWidth: 400
    property real popupHeight: 300
    property real triggerX: 0
    property real triggerY: 0
    property bool isOpen: false

    signal closed

    function open() {
        isOpen = true;
    }

    function close() {
        isOpen = false;
        closed();
    }

    // Calculate popup position based on trigger
    readonly property real popupX: Math.max(4, Math.min(window.screen.width - popupWidth - 4, triggerX - popupWidth / 2))
    readonly property real popupY: Math.max(4, triggerY)

    PanelWindow {
        id: window
        visible: root.isOpen
        color: "transparent"

        WlrLayershell.namespace: "popup"
        WlrLayershell.layer: WlrLayershell.Top
        WlrLayershell.exclusiveZone: -1
        WlrLayershell.keyboardFocus: root.isOpen ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

        anchors {
            left: true
            top: true
        }

        WlrLayershell.margins {
            left: root.popupX
            top: root.popupY
        }

        implicitWidth: root.popupWidth
        implicitHeight: root.popupHeight

        Rectangle {
            anchors.fill: parent
            color: "#1e1e1e"
            border.color: "#3e3e3e"
            border.width: 1
            radius: 8

            Loader {
                id: contentLoader
                anchors.fill: parent
                active: root.isOpen
            }
        }

        Keys.onEscapePressed: root.close()
    }
}
