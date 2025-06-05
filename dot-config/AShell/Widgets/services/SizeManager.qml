pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Singleton {
    id: size_manager
    property int island_width: 1
    property int bar_width: 1
    property int bar_height: 1
    property int bar_gap: 10
}
