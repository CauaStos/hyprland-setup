import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../config/"
import "../globals/components/"
import "../services/"
import "./Island/"
import "./modules"
Scope {

    PanelWindow {//Bar
        id: window
        color: 'transparent'
        margins {
            top: 10
            bottom: 10
            left: 10
            right: 10
        }
        anchors {
            top: true
            left: true
            right: true
            bottom: true
          }

        mask: Region {
            width: window.width
            height: window.height
            intersection: Intersection.Subtract
        }

        RowLayout{
            id: bar
            spacing: 10
            anchors {
                left: parent.left
                right: parent.right
            }
            height: 50

            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: bar.height
                radius: 10
                color: Colors.surface

                Row{
                    anchors.centerIn: parent.verticalCenter

                    Activity {}
                    Workspaces {}
                }
            }

            Island {}

            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 10
                color: Colors.surface
                Layout.maximumHeight: bar.height
            }
        }

        onWidthChanged: () => {
            SizeManager.bar_width = width
            SizeManager.bar_height = height
        }
      }
  }
