import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../../../../config/"
import "../../../../globals/components/"
import "../../../"
import "../"

Rectangle {
    id: workspaceDisplay
    property int workspace_size: BarConfig.container_height * 0.9;
    property int workspace_active_width: workspace_size * 3

    radius: 10000
    color: Colors.surface_container

    implicitWidth: workspaceIndicators.implicitWidth + BarConfig.container_padding
    implicitHeight: workspaceIndicators.implicitHeight + BarConfig.container_padding



    Row {
        id:workspaceIndicators
        anchors.centerIn: parent
        spacing: BarConfig.container_padding / 2

        Repeater{
            model: Hyprland.workspaces.values.filter(workspace => workspace.id >= 1)
            delegate: Rectangle {
                property bool isActive: modelData.id == WorkspaceConfig.focused_workspace

                width: isActive ? workspaceDisplay.workspace_active_width : workspaceDisplay.workspace_size
                height: workspaceDisplay.workspace_size
                radius: 10000
                color: isActive ? Colors.inverse_primary : Colors.primary

                StyledText {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    weight: 700
                    font.pixelSize: BarConfig.h5
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
