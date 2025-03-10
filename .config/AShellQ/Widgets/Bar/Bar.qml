import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../globals/components/"
import "../../config/"

Scope {

    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        color: "transparent"

        height: 30


        Rectangle {
            anchors.fill: parent
            color: Colors.surface
            opacity: 0.95


            RowLayout {
                    width: parent.width
                    Item {
                                   Layout.fillWidth: true  // Spacer pushes "Center" to the middle
                               }


                    StyledButton {
                        background_color: Colors.surface_container
                        id: label
                        width: 100
                        Layout.preferredWidth: width  // Use preferred width to control size


                        Behavior on width {
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.OutCubic
                            }
                        }

                        Layout.fillWidth:false
                        text: "center"
                    }
                    StyledButton {
                        background_color: Colors.surface_container
                        Layout.fillWidth:false
                        text: "fodase"
                        onClicked: label.width = label.width === 0 ? 100 : 0;
                    }



                    Item {
                        Layout.fillWidth: true  // Spacer pushes "Center" to the middle
                    }


            }




        }





    }

}
