import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../../../globals/components/"
import "../../../../config/"
import "../../"
import "./Widgets/"
import "./Widgets/Player"


PanelWindow {
    id: window
    screen: Quickshell.screens[0]
    //Doing this because animations are jagged if window width and height follows the island sizes.

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    width: screen.width
    height: screen.height
    color: 'transparent'


    mask: Region { //Allowing mouse events to pass only to Island
        item: island
        intersection: Intersection.Intersection
    }

    WrapperRectangle {
        id: island

        //Anchors
        anchors.top: parent
        anchors.horizontalCenter: parent.horizontalCenter

        //Variables
        property var child_width: child.implicitWidth
        property var child_height: child.implicitHeight

        //Island Position
        property int position: child_height ? BarConfig.bar_height/2 - child_height/2 : BarConfig.bar_height/2 - height/2
        property int widgetActivePosition: BarConfig.bar_height * 1.25

        //Properties
        width: child_width
        height: child_height
        y: IslandConfig.isWidgetOpen ? widgetActivePosition : position
        color: 'transparent'
        radius: child.radius

        //Listeners
        Component.onCompleted: {
            IslandConfig.bar_island_width = width
            currentIndexChanged.connect(() => console.log("fodase"))
        }

        property bool isWidthTrackable: true
        onWidthChanged: {
            if(isWidthTrackable) IslandConfig.bar_island_width = width
            if(IslandConfig.isWidgetOpen && width>-2 && width<2) isWidthTrackable = false
            if(!IslandConfig.isWidgetOpen && width>-2 && width<2) isWidthTrackable = true
        }



        //Widgets
        child: idle
        Idle {id: idle}
        Player{id: player}

        property bool childChangeAnimation: false
        onChildChanged: childChangeAnimation = true
        Behavior on width {
            enabled: island.childChangeAnimation
            SequentialAnimation{
                NumberAnimation { duration: 200 }
                ScriptAction{
                    script: island.childChangeAnimation = false
                }
            }
        }
    }





}
