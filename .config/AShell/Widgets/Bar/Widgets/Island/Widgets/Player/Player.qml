import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import "../../../../../globals/components/"
import "../../../../../../config/"
import "../../../../"
import "../../"
import "../Components/"
import "./Components/"

Container {
        id: player
        minimized_widget: Collapsed {}
        active_widget: Expanded {}
    }
