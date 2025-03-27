import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import "../globals/components/"
import "../../config/"
import "./Widgets/Island"
import "./Widgets/Workspace"

    PanelWindow {
        screen: Quickshell.screens[0]

        anchors {
            top: true
            left: true
            right: true
        }
        color: "transparent"

        height: BarConfig.bar_height

        Rectangle { //Bar container
            anchors.fill: parent

            color: Colors.surface
            opacity: 0.95


            RowLayout { //Bar - Row
                id: bar
                anchors.fill: parent
                anchors.leftMargin: BarConfig.container_margin
                anchors.rightMargin: BarConfig.container_margin

                spacing: BarConfig.container_margin




                Rectangle { //Left Container
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: 'transparent'
                    implicitHeight: workspace.implicitHeight

                    Workspace {}

                }

                Rectangle { //Center container
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: 'transparent'
                    RowLayout {
                        anchors.fill: parent
                        spacing: BarConfig.inner_container_margin

                        Rectangle { //Clock
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: 'transparent'

                        }
                        Rectangle { //Island
                            implicitWidth: IslandConfig.bar_island_width
                            Layout.fillHeight: true
                            color: 'transparent'

                        }
                        Rectangle { //Utilities
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: 'transparent'
                        }
                    }


                }
                Rectangle { //Right Container
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: 'transparent'
                    //Tray: Coming Soon™

                }
            }




        }




    }
