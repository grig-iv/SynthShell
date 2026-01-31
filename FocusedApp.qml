import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick

Item {
    width: 32
    implicitHeight: 32

    readonly property var activeWindow: ToplevelManager.activeToplevel

    IconImage {
        id: appIcon
        anchors.fill: parent
        
        source: activeWindow && activeWindow.appId 
                ? "image://icon/" + activeWindow.appId 
                : ""
        
        smooth: true
        asynchronous: true
    }
}
