import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

    Button {

        background: Rectangle {
            id: bg
            color: 'black'
        }

        id: styledButton
        property int weight: 600
        font{
            family: "Quicksand"
            weight: styledButton.weight
        }
        text: "grow/shrink"
    }
