pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Singleton {

    FileView {
      id: jsonFile
      path: Qt.resolvedUrl("colors.json")

      // Forces the file to be loaded by the time we call JSON.parse().
      // See blockLoading's property documentation for details.
      watchChanges: true
      blockLoading: false

      onLoaded: {
          console.log("oi")

      }
      onFileChanged: {
          console.log("File changed, reloading...");
          jsonFile.load();  // Assuming this reloads the file (if necessary)
      }

    }
}



// property color background: Qt.rgba(26/255,18/255,13/255,1)
// property color error: Qt.rgba(255/255,180/255,171/255,1)
// property color error_container: Qt.rgba(147/255,0/255,10/255,1)
// property color inverse_on_surface: Qt.rgba(56/255,46/255,41/255,1)
// property color inverse_primary: Qt.rgba(140/255,78/255,41/255,1)
// property color inverse_surface: Qt.rgba(240/255,223/255,215/255,1)
// property color on_background: Qt.rgba(240/255,223/255,215/255,1)
// property color on_error: Qt.rgba(105/255,0/255,5/255,1)
// property color on_error_container: Qt.rgba(255/255,218/255,214/255,1)
// property color on_primary: Qt.rgba(83/255,34/255,1/255,1)
// property color on_primary_container: Qt.rgba(255/255,219/255,202/255,1)
// property color on_primary_fixed: Qt.rgba(51/255,18/255,0/255,1)
// property color on_primary_fixed_variant: Qt.rgba(111/255,55/255,20/255,1)
// property color on_secondary: Qt.rgba(67/255,43/255,29/255,1)
// property color on_secondary_container: Qt.rgba(255/255,219/255,202/255,1)
// property color on_secondary_fixed: Qt.rgba(43/255,22/255,10/255,1)
// property color on_secondary_fixed_variant: Qt.rgba(92/255,65/255,50/255,1)
// property color on_surface: Qt.rgba(240/255,223/255,215/255,1)
// property color on_surface_variant: Qt.rgba(215/255,194/255,185/255,1)
// property color on_tertiary: Qt.rgba(52/255,50/255,8/255,1)
// property color on_tertiary_container: Qt.rgba(234/255,229/255,171/255,1)
// property color on_tertiary_fixed: Qt.rgba(30/255,28/255,0/255,1)
// property color on_tertiary_fixed_variant: Qt.rgba(75/255,72/255,29/255,1)
// property color outline: Qt.rgba(159/255,141/255,132/255,1)
// property color outline_variant: Qt.rgba(82/255,68/255,60/255,1)
// property color primary: Qt.rgba(255/255,182/255,142/255,1)
// property color primary_container: Qt.rgba(111/255,55/255,20/255,1)
// property color primary_fixed: Qt.rgba(255/255,219/255,202/255,1)
// property color primary_fixed_dim: Qt.rgba(255/255,182/255,142/255,1)
// property color scrim: Qt.rgba(0/255,0/255,0/255,1)
// property color secondary: Qt.rgba(230/255,190/255,171/255,1)
// property color secondary_container: Qt.rgba(95/255,67/255,52/255,1)
// property color secondary_fixed: Qt.rgba(255/255,219/255,202/255,1)
// property color secondary_fixed_dim: Qt.rgba(230/255,190/255,171/255,1)
// property color shadow: Qt.rgba(0/255,0/255,0/255,1)
// property color surface: Qt.rgba(26/255,18/255,13/255,1)
// property color surface_bright: Qt.rgba(65/255,55/255,50/255,1)
// property color surface_container: Qt.rgba(39/255,30/255,25/255,1)
// property color surface_container_high: Qt.rgba(50/255,40/255,35/255,1)
// property color surface_container_highest: Qt.rgba(61/255,51/255,46/255,1)
// property color surface_container_low: Qt.rgba(34/255,26/255,21/255,1)
// property color surface_container_lowest: Qt.rgba(20/255,12/255,9/255,1)
// property color surface_dim: Qt.rgba(26/255,18/255,13/255,1)
// property color surface_variant: Qt.rgba(82/255,68/255,60/255,1)
// property color tertiary: Qt.rgba(206/255,201/255,145/255,1)
// property color tertiary_container: Qt.rgba(75/255,72/255,29/255,1)
// property color tertiary_fixed: Qt.rgba(234/255,229/255,171/255,1)
// property color tertiary_fixed_dim: Qt.rgba(206/255,201/255,145/255,1)
// property color source_color: Qt.rgba(192/255,96/255,33/255,1)
