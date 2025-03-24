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

Column {
    id: activeWidget
    anchors.centerIn: parent

    visible: IslandConfig.isWidgetOpen


    property int radius: 20

       Row {
           Image {
               id: trackArt
               source: "file:///home/astro/Downloads/puper.jpg" // Example source for the track art
               width: 100
               height: 100


               layer.enabled: true
               layer.effect: OpacityMask {
                   maskSource: Rectangle {  // Don't try to mask with preview or else it will crash 💔
                       width: trackArt.width
                       height: trackArt.height
                       radius: activeWidget.radius
                   }
               }


               MouseArea {
                   anchors.fill: parent
                   onClicked: IslandConfig.isWidgetOpen = !IslandConfig.isWidgetOpen

               }
           }

           Column {
               StyledText {
                   font.pixelSize: BarConfig.h3
                   color: Colors.primary
                   text: "Smile of the End"
               }

               StyledText {
                   font.pixelSize: BarConfig.h5
                   color: Colors.outline
                   text: "X2N_" // Replace with dynamic content for the artist
               }
           }
       }

       // Second Row with Playback Controls and Track Progress
       Row {
           // Playback Controls (Backward, Play/Pause, Forward)
           Row {
               Text {
                   text: "<<"
                   // Add functionality for backward
               }

               Text {
                   text: "Play/Pause"
                   // Add functionality for play/pause
               }

               Text {
                   text: ">>"
                   // Add functionality for forward
               }
           }

           // Column for Track Progress and Length
           Column {
               Row {
                   // Track Progress
                   Text {
                       text: "45" // Example progress value
                       width: 200
                   }

                   // Track Length
                   Text {
                       text: "3:45 / 5:00" // Example track length and progress
                       anchors.verticalCenter: parent.verticalCenter
                   }
               }
               Slider {
                    id: slider
                    width: 200
                    height: 10


                    from: 0
                    value: 25
                    to: 100

                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle{
                            width: slider.width
                            height: slider.height
                            radius: 2000
                        }
                        antialiasing: true
                        smooth: true
                    }

                    background: Rectangle {
                        id: sliderBackground
                        color: Colors.surface_container_highest

                        Rectangle {
                            id: sliderControl
                            width: slider.visualPosition * parent.width
                            height: parent.height
                            color: Colors.primary
                        }
                    }

                    handle: null

               }
           }
       }
   }
