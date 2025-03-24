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

ColumnLayout { //Workspace Info
    spacing: 0
    StyledText {
        font.pixelSize: BarConfig.h4
        color: Colors.on_surface
        text: "astro@arch"
    }
    StyledText{
        font.pixelSize: BarConfig.h3
        color: Colors.primary
        text: "Workspace " + WorkspaceConfig.focused_workspace
    }
}
