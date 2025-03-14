pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Singleton {


    property int screen_width: 1000
    property int screen_height: 1000

    property int bar_width: screen_width
    property int bar_height: screen_height * 0.06;

    property int container_width: bar_height * 0.45;
    property int container_height: bar_height * 0.45;
    property int container_padding: bar_height * 0.2;
    property int container_margin: bar_width * 0.0125;

    property int h1: screen_height * 0.03;
    property int h2: screen_height * 0.025;
    property int h3: screen_height * 0.0175;
    property int h4: screen_height * 0.015;
    property int h5: screen_height * 0.014;

}
