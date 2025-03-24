import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import "../../../../../../globals/components/"
import "../../../../../../../config/"
import "../../../../../"
import "../../../"

RowLayout{
    id: minimizedWidget
    anchors.centerIn: parent

    visible: !IslandConfig.isWidgetOpen

    Component.onCompleted: {

        console.log(implicitWidth)
    }

    Canvas {
        id: canvas
        implicitWidth: IslandConfig.island_size + BarConfig.inner_container_margin
        implicitHeight: IslandConfig.island_size + BarConfig.inner_container_margin


        property real progress: 0.5
        property bool playing: false

        Image {
            id: svgIcon
            anchors.centerIn: parent
            source: canvas.playing ? `file:///${Quickshell.env("HOME")}/.config/AShell/icons/pause.svg` : `file:///${Quickshell.env("HOME")}/.config/AShell/icons/play.svg`
            visible: false
            width: canvas.height/2
            height: canvas.height/2
        }
        ColorOverlay {
            anchors.fill: svgIcon
            source: svgIcon
            color: Colors.primary  // make image like it lays under red glass
        }

        onPaint: {
            var ctx = canvas.getContext("2d")
            ctx.clearRect(0, 0, canvas.width, canvas.height) // Clear canvas each time it's painted

            var radius = canvas.width / 2;
            var lineWidth = 3;

            //Background Circle
            ctx.beginPath();
            ctx.arc(radius, radius, radius - lineWidth / 2, 0, 2 * Math.PI);
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = Colors.on_secondary;
            ctx.stroke();

            //Progress
            ctx.beginPath();
            ctx.arc(radius, radius, radius - lineWidth / 2, -Math.PI / 2, -Math.PI / 2 + (2 * Math.PI * progress));
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = Colors.primary;
            ctx.stroke();
        }
        MouseArea {
            anchors.fill: parent
            onClicked: canvas.playing = !canvas.playing

        }
    }

    StyledText {
        color: Colors.primary
        font.pixelSize: BarConfig.h5
        text: "  •  "
    }
    StyledText {
        Layout.preferredWidth: IslandConfig.island_size * 6
        elide: Text.ElideRight

        font.pixelSize: BarConfig.h5
        color: Colors.primary
        text: "Smile of the End - X2N_ porra porra porra"

        MouseArea {
            anchors.fill: parent
            onClicked: IslandConfig.isWidgetOpen = !IslandConfig.isWidgetOpen

        }
    }

    StyledText {
        color: Colors.primary
        font.pixelSize: BarConfig.h5
        text: " "
    }
}
