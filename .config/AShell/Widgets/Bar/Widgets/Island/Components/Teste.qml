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

Rectangle {
        id: rectangletest
        width: 200
        height: 100
        radius: 10000

        StyledText {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            weight: 700
            font.pixelSize: BarStyle.h5
            text: "Oi"

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
