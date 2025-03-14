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
            hintingPreference: Font.PreferNoHinting
        }
        text: parent.text
    }
