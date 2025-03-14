import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

    Button {
        id: styledButton
        property color background_color: '#ff0000'
        background: Rectangle {
            id: bg
            color: styledButton.background_color
        }

        property int weight: 600
        font{
            family: "Quicksand"
            weight: styledButton.weight
        }
        text: "grow/shrink"
    }
