import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


    Text{
        id: styledtext
        property int weight: 600
        font{
            family: "Quicksand"
            weight: styledtext.weight
        }
        text: parent.text
        color: styledtext.text_color
    }
