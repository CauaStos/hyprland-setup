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

RowLayout { //Workspace
    id: workspace

    //Anchors
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter

    //Properties
    spacing: BarConfig.container_margin


    //Components
    WorkspaceInfo {}

    WorkspaceDisplay {}



}
