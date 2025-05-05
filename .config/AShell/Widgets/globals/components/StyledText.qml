import Quickshell
import QtQuick


    Text{
        id: styledtext
        property int weight: 600
        font{
            family: "SF Pro Text"
            weight: styledtext.weight
            hintingPreference: Font.PreferNoHinting
        }
        text: parent.text
    }
