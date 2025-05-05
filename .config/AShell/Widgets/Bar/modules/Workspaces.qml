import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.Mpris
import "../../../config/"
import "../../globals/components/"
import "../../services/"


    RowLayout { //Island wrapper for background during transition
        id: workspace
        spacing: 0

        property var workspaces: Hyprland.workspaces



        Repeater {
                model: workspace.workspaces

                delegate: Rectangle {
                    width: 20
                    height: 20
                    radius: 10
                    color: model.active ? "#66f" : "#333"
                    Layout.alignment: Qt.AlignVCenter
                }
        }

        Component.onCompleted: () => console.log(workspaces)


    }
