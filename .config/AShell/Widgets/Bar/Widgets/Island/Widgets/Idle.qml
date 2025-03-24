import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../../../../globals/components/"
import "../../../../../config/"
import "../../../"
import "../../"
import "../"

Rectangle {
        id: idle

        implicitWidth: row.implicitWidth + BarConfig.container_padding * 1.5
        implicitHeight: IslandConfig.island_size + BarConfig.container_padding


        radius: 2000
        color: Colors.surface_container
        clip: true

        Row{
            id: row
            anchors.centerIn: parent

            StyledText {
                id: clock
                color: Colors.on_surface
                font.pixelSize: BarConfig.h4
                text: Qt.formatTime(new Date(), "hh:mm")
            }
            StyledText {
                color: Colors.primary
                font.pixelSize: BarConfig.h4

                text: "  •  "
            }
            StyledText {
                id: date
                color: Colors.on_surface
                font.pixelSize: BarConfig.h4
                text: Qt.formatDate(new Date(), "d/M")
            }
        }

        Timer{
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                clock.text = Qt.formatTime(new Date(), "hh:mm")
                date.text = Qt.formatDate(new Date(), "d/M")
            }
        }



    }
