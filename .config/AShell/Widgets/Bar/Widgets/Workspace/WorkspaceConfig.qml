pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../../globals/components/"
import "../../../../config/"
import "../../"
import "./Components/"
import "./"

Singleton {

    //Properties
    property var focused_workspace: 0



    //Listeners
    Process {
        id: fetchActiveWorkspace
        running: true

        command: ["hyprctl", "activeworkspace", "-j"]

        stdout: SplitParser {
            splitMarker: ''
            onRead: data => {
                let activeworkspace = JSON.parse(data)
                WorkspaceConfig.focused_workspace = activeworkspace.id
            }
        }
    }

    Component.onCompleted: {
        Hyprland.rawEvent.connect((event) => {
            switch(event.name){
                case 'workspace':
                    fetchActiveWorkspace.running = true
                    break
                case 'focusedmon':
                    fetchActiveWorkspace.running = true
                    break
            }
        })
    }
}
