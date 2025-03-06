pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item{
    id: styledtext
    property string text: "Nothing"
    property int weight: 600

    Text{
        font{
            family: "Quicksand"
            weight: styledtext.weight
        }
        text: parent.text
    }
}
