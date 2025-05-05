import Quickshell
import QtQuick
import "../../../config/"


    Text{
        id: styledtext

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

        property int weight: 500
        color: Colors.on_surface
        font{
            family: "SF Pro Text"
            styleName: lookup_weight(weight)
            hintingPreference: Font.PreferNoHinting
        }

    }
