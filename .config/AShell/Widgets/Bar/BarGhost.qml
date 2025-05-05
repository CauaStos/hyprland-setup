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
Scope {

    PanelWindow {//Ghost
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
          }
        height: 50
      }
  }
