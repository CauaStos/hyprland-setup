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

        function lookup_weight(weight) {
            switch(weight){
                case 100: return "Ultralight"
                case 200: return "Thin"
                case 300: return "Light"
                case 400: return "Regular"
                case 500: return "Medium"
                case 600: return "Semibold"
                case 700: return "Bold"
                case 800: return "Heavy"
                case 900: return "Black"
                return "Regular"
            }
        }

        property int weight: 600
        font{
            family: "SF Pro Text"
            styleName: lookup_weight(weight)
        }
    }
