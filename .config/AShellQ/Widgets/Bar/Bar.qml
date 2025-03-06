import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../globals/components/"
import "../../config/Colors.qml"

Scope {

    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }

        height: 30
        RowLayout {
                width: parent.width
                Item {
                               Layout.fillWidth: true  // Spacer pushes "Center" to the middle
                           }
                StyledButton {
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
