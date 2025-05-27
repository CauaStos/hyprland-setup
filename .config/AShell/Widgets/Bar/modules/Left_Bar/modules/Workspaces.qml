import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.Mpris
import "../../../../../config/"
import "../../../../globals/components/"
import "../../../../services/"

    RowLayout {
        id: workspaceComponent
        Layout.leftMargin: 10

        spacing: 0
        Layout.fillHeight: true

        property var workspaces: (() =>{
            let result = []
            for(let i = 0; i<10; i++){
                result[i] = {
                    id: i,
                    enabled: false
                }
            }
            return result
        })()
        property int focused_workspace: 0

        Repeater {
            id: repeater

            model: workspaceComponent.workspaces
            delegate: Rectangle {
                id: workspace_indicator
                implicitWidth: workspaceComponent.focused_workspace == index ? 80 : indicator_width
                implicitHeight: 15
                color: 'transparent'

                required property var modelData
                required property int index

                Rectangle{
                    color: Colors.primary
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    radius: 10
                }

                property int indicator_width: workspaceComponent.workspaces[index].enabled ? 20 : 1

                Component.onCompleted: {
                    fetchWorkspaces.fetched.connect(() => {
                        indicator_width = workspaceComponent.workspaces[index].enabled ? 20 : 0
                    })
                }

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 200
                    }
                }
            }
        }



        Process {
            id: fetchWorkspaces
            signal fetched()

            running: true
            command: [ "hyprctl", "workspaces", "-j" ]
            stdout: SplitParser {
                splitMarker: ""
                onRead: data => {
                    data = JSON.parse(data)
                    data = data.filter((entry) => entry.id>0 && entry.id<=10)
                    workspaceComponent.workspaces.forEach((workspace) => {
                        let hasWorkspace = false
                        data.forEach((entry) => {
                            if(workspace.id == entry.id-1){
                                workspace.enabled = true
                                hasWorkspace = true
                                return
                            }
                        })
                        if(!hasWorkspace) workspace.enabled = false
                    })
                    fetchWorkspaces.fetched()
                }
            }
        }

        Component.onCompleted: {
            Hyprland.rawEvent.connect((event) => {
                if(event.name == "workspacev2") {
                    fetchWorkspaces.running = true
                    workspaceComponent.focused_workspace = parseInt(event.data.split(",")[0]) - 1
                }

                if(event.name == "destroyworkspacev2"){
                    fetchWorkspaces.running = true
                    const destroyed_workspace = parseInt(event.data.split(",")[0]) - 1
                    workspaceComponent.workspaces[destroyed_workspace].enabled = false
                }

                if(event.name == "focusedmonv2"){
                    fetchWorkspaces.running = true
                    workspaceComponent.focused_workspace = event.data.split(",")[1] - 1
                }
            })
        }


    }
