import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../config/"
import "../globals/components/"

Scope {

    PanelWindow {
        color: 'red'
        margins {
            top: 10
            bottom: 10
            left: 10
            right: 10
        }
        anchors {
            top: true
            left: true
        }
        height: 50
    }

    PanelWindow {
        color: 'red'
        margins {
            top: 10
            bottom: 10
            left: 10
            right: 10
        }
        anchors {
            top: true
        }
        height: 50
    }

    PanelWindow {
        color: 'red'
        margins {
            top: 10
            bottom: 10
            left: 10
            right: 10
        }
        anchors {
            top: true
            right: true
        }
        height: 50
    }



}
