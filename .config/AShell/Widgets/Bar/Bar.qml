import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import "../globals/components/"
import "../../config/"
import "./Components/"


    PanelWindow {
        screen: Quickshell.screens[0]

        anchors {
            top: true
            left: true
            right: true
        }
        color: "transparent"


        height: bar.implicitHeight + BarStyle.container_padding * 2

        Rectangle { //Bar container
            anchors.fill: parent

            color: Colors.surface
            opacity: 0.95


            RowLayout { //Bar - Row
                id: bar
                anchors.fill: parent
                anchors.leftMargin: BarStyle.container_margin
                anchors.rightMargin: BarStyle.container_margin

                spacing: BarStyle.container_margin



                Container {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    background_color: 'transparent'
                    implicitHeight: workspace.implicitHeight


                    RowLayout { //Workspace
                        id: workspace
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        property var focused_workspace: 0
                        spacing: BarStyle.container_margin

                        ColumnLayout { //Workspace Info
                            spacing: 0
                            StyledText {
                                font.pixelSize: BarStyle.h4
                                color: Colors.on_surface
                                text: "astro@arch"
                            }
                            StyledText{
                                font.pixelSize: BarStyle.h3
                                color: Colors.primary
                                text: "Workspace " + workspace.focused_workspace
                            }
                        }

                        Rectangle { //WorkspaceDisplay
                            id: workspaceDisplay
                            property int workspace_size: BarStyle.container_height * 0.9;
                            property int workspace_active_width: workspace_size * 3

                            radius: 10000
                            color: Colors.surface_container

                            implicitWidth: workspaceIndicators.implicitWidth + BarStyle.container_padding
                            implicitHeight: workspaceIndicators.implicitHeight + BarStyle.container_padding



                            Row {
                                id:workspaceIndicators
                                anchors.centerIn: parent
                                spacing: BarStyle.container_padding / 2

                                Repeater{
                                    model: Hyprland.workspaces.values.filter(workspace => workspace.id >= 1)
                                    delegate: Rectangle {
                                        property bool isActive: modelData.id == workspace.focused_workspace

                                        width: isActive ? workspaceDisplay.workspace_active_width : workspaceDisplay.workspace_size
                                        height: workspaceDisplay.workspace_size
                                        radius: 10000
                                        color: isActive ? Colors.inverse_primary : Colors.primary

                                        StyledText {
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            weight: 700
                                            font.pixelSize: BarStyle.h5
                                            color: isActive ? Colors.inverse_primary : Colors.on_primary
                                            text: modelData.id

                                        }

                                        Behavior on width {
                                            NumberAnimation {
                                                    duration: 500
                                                    easing.type: Easing.OutCubic
                                            }
                                        }

                                        Behavior on color {
                                            ColorAnimation {
                                                duration: 300
                                                easing.type: Easing.OutCubic
                                            }
                                        }

                                    }
                                }
                            }

                        }


                        Process {
                            id: fetchActiveWorkspace
                            running: true

                            command: ["hyprctl", "activeworkspace", "-j"]

                            stdout: SplitParser {
                                splitMarker: ''
                                onRead: data => {
                                    let activeworkspace = JSON.parse(data)
                                    workspace.focused_workspace = activeworkspace.id
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
                            console.log(BarStyle.h5)
                            console.log(BarStyle)
                        }

                    }
                }

                Container { //Center container
                    Layout.fillWidth: true
                    Layout.fillHeight: true


                }
                Container { //Right Container
                    Layout.fillWidth: true
                    Layout.fillHeight: true


                }
            }




        }




    }
