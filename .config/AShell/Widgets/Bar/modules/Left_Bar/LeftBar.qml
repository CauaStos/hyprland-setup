import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../../../config/"
import "../../../globals/components/"
import "../../../services/"
import "./modules/"

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.maximumHeight: bar.height
    radius: 10
    color: Colors.surface


    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        Activity {}
        Workspaces {}
    }
}
