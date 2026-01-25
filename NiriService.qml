pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var kbLayouts: []
    property string currKbLayout: ""

    Process {
        id: events
        command: ["niri", "msg", "--json", "event-stream"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                try {
                    let data = JSON.parse(line);

                    if (data?.KeyboardLayoutsChanged?.keyboard_layouts != undefined) {
                        root.kbLayouts = data.KeyboardLayoutsChanged.keyboard_layouts.names;
                        root.currKbLayout = root.kbLayouts[Number(data.KeyboardLayoutsChanged.keyboard_layouts.current_idx)];
                    }

                    if (data?.KeyboardLayoutSwitched != undefined) {
                        root.currKbLayout = root.kbLayouts[Number(data.KeyboardLayoutSwitched.idx)];
                    }
                } catch (e) {
                    console.error(e);
                }
            }
        }
    }
}
