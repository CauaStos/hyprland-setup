import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../../../globals/components/"
import "../../../../config/"
import "../../"


PanelWindow {
    WlrLayershell.layer: WlrLayer.Overlay
    width: island.width
    height: island.height

    color: 'transparent'

    anchors{
        top: true
    }

    margins.top: 450




    // Rectangle {
    //     id: island
    //     property int island_size: BarStyle.container_height * 0.9;
    //     property int island_active_test: island_size * 3


    //     radius: 10000
    //     color: 'green'

    //     width: widget.width + BarStyle.container_padding
    //     height: widget.height + BarStyle.container_padding


    //     MouseArea {
    //         anchors.fill: parent
    //         onClicked: {
    //             widget.currentIndex== 0 ? widget.currentIndex = 1 : widget.currentIndex = 0
    //         }
    //     }

    //     StackLayout {
    //         id:widget
    //         anchors.centerIn: parent
    //         currentIndex: 0

    //         width: children[currentIndex].implicitWidth
    //         height: children[currentIndex].implicitHeight

    //         Behavior on width {
    //             NumberAnimation {
    //                     duration: 100
    //                     easing.type: Easing.OutCubic
    //             }
    //         }

    //         Rectangle {
    //             implicitWidth: island.island_size
    //             implicitHeight: island.island_size
    //             radius: 10000
    //             color: 'red'

    //             StyledText {
    //                 anchors.fill: parent
    //                 horizontalAlignment: Text.AlignHCenter
    //                 verticalAlignment: Text.AlignVCenter
    //                 weight: 700
    //                 font.pixelSize: BarStyle.h5
    //                 color: "blue"
    //                 text: "oi"

    //             }


    //         }

    //         Rectangle {
    //             implicitWidth: island.island_active_test
    //             implicitHeight: island.island_size
    //             radius: 10000
    //             color: 'red'

    //             StyledText {
    //                 anchors.fill: parent
    //                 horizontalAlignment: Text.AlignHCenter
    //                 verticalAlignment: Text.AlignVCenter
    //                 weight: 700
    //                 font.pixelSize: BarStyle.h5
    //                 color: "blue"
    //                 text: "teste"

    //             }

    //         }

    //     }


    // }

}
