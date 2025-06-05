import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.Mpris
import "../../../config/"
import "../../globals/components/"
import "../../services/"


    Rectangle { //Island wrapper for background during transition
        id: island_wrapper
        Layout.fillHeight: true
        Layout.preferredWidth: island.implicitWidth
        Layout.preferredHeight: island.implicitHeight
        Layout.minimumWidth: 100
        radius: 10
        color: Colors.surface

        Component.onCompleted: () => {
            //Debuggings
             console.log(implicitWidth)
        }


        StackView {
            id: island
            anchors.fill: parent
            initialItem: playerComponent

            implicitWidth: currentItem.implicitWidth
            implicitHeight: currentItem.implicitHeight

            Timer {
                id: switchTimer
                interval: 1500 // 3 seconds
                running: true
                repeat: false
                onTriggered: {
                    island.push(clockComponent);

                }
            }

            // Components
            Component {
                id: playerComponent
                RowLayout{
                    id: player
                    anchors.fill: parent
                    spacing: 0




                    property var player_mpris: Mpris.players.values[0]
                    property string current_track: player_mpris.trackTitle
                    property var track_image: player_mpris.trackArtUrl
                    property double song_length: player_mpris.length
                    property double time_ellapsed: player_mpris.position

                    Control {
                        padding: 5
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        contentItem: ClippingWrapperRectangle {
                            radius: 10
                            Image {
                                source: player.track_image
                                fillMode: Image.PreserveAspectFit
                                smooth: true
                                mipmap: true
                                antialiasing: true
                            }
                        }
                    }

                    Control {
                        padding: 5
                        Layout.fillWidth: true
                        Layout.minimumWidth: 1
                        Layout.alignment: Qt.AlignLeft
                        contentItem: StyledText {
                            text: player.current_track
                            font.pixelSize: 16
                            color: 'white'
                        }
                    }



                }
            }

            Component {
                id: clockComponent
                    StyledText {
                        SystemClock {
                            id: clock
                        }
                        verticalAlignment: Qt.AlignVCenter
                        text: Qt.formatDateTime(clock.date, "ddd, MMM d • HH:mm")
                    }

            }

            Component {
                id: lockComponent
                Rectangle {
                    color: "#511"
                    anchors.fill: parent
                    Text {
                        text: "🔒 Locked"
                        anchors.centerIn: parent
                    }
                }
            }


            pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                    easing.type: Easing.Bezier
                    easing.bezierCurve: [0.4, 0.0, 0.2, 1.0]
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                    easing.type: Easing.Bezier
                    easing.bezierCurve: [0.4, 0.0, 0.2, 1.0]
                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                    easing.type: Easing.Bezier
                    easing.bezierCurve: [0.4, 0.0, 0.2, 1.0]
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 500
                    easing.type: Easing.Bezier
                    easing.bezierCurve: [0.4, 0.0, 0.2, 1.0]
                }
            }
        }

        Behavior on Layout.preferredWidth {
            NumberAnimation{
                duration: 100
                easing.type: Easing.Bezier
                easing.bezierCurve: [0.4, 0.0, 0.2, 1.0]
            }
        }
    }
