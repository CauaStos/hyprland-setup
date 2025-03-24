import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import "../../../../../globals/components/"
import "../../../../../../config/"
import "../../../../"
import "../../"

Rectangle {
        id: container

        radius: IslandConfig.isWidgetOpen ? 20 : 20000
        clip: true

        property real widget_width: minimized_widget.implicitWidth + BarConfig.container_padding
        property real widget_height: minimized_widget.implicitHeight + BarConfig.container_padding

        property real active_widget_width: active_widget.implicitWidth + BarConfig.container_padding * 4
        property real active_widget_height: active_widget.implicitHeight + BarConfig.container_padding * 4

        implicitWidth: IslandConfig.isWidgetOpen ? active_widget_width : widget_width
        implicitHeight: IslandConfig.isWidgetOpen ? active_widget_height : widget_height
        color: Colors.surface_container

        //Widget
        property Item minimized_widget: undefined
        property Item active_widget: undefined

        onMinimized_widgetChanged: {
            minimized_widget.parent = container
        }

        onActive_widgetChanged: {
            active_widget.parent = container
        }


        Behavior on implicitWidth {
            NumberAnimation{
                duration: 200
                easing: Easing.OutCubic
            }
        }
        Behavior on implicitHeight {
            NumberAnimation{
                duration: 200
                easing: Easing.OutCubic
            }
        }
    }
