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


    ColumnLayout { //Island wrapper for background during transition
        id: activity
        anchors.centerIn: parent.verticalCenter
        spacing: 0

        Control {
            leftPadding: 15
            Layout.fillWidth: true
            Layout.fillHeight: true
            background: Rectangle {
                color: 'red'
            }
            contentItem: StyledText {
                color: Colors.primary
                weight: 600
                text: "Zen Browser"
            }
        }

        Control {
            leftPadding: 15
            Layout.fillWidth: true
            Layout.fillHeight: true
            background: Rectangle {
                color: 'red'
            }
            contentItem: StyledText {
                color: Colors.on_surface_variant
                weight: 400
                text: "Shell - Figma"
            }
        }

        Behavior on width {
            NumberAnimation{
                duration: 100
                easing.type: Easing.Bezier
                easing.bezierCurve: [0.4, 0.0, 0.2, 1.0]
            }
        }
    }
