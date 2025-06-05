pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Singleton {
    id: colors

    signal colorsChanged()

    function alpha_color(color, opacity) {
        let alpha = Math.round(opacity * 255)
        alpha = alpha.toString(16).toUpperCase().padStart(2, '0')
        return `#${alpha}${color.toString().substring(1,7)}`
    }


    property color error:  null
    property color error_container: null
    property color inverse_on_surface:  null
    property color inverse_primary:  null
    property color inverse_surface:  null
    property color on_background:  null
    property color on_error:  null
    property color on_error_container:  null
    property color on_primary:  null
    property color on_primary_container:  null
    property color on_primary_fixed:  null
    property color on_primary_fixed_variant:  null
    property color on_secondary:  null
    property color on_secondary_container:  null
    property color on_secondary_fixed:  null
    property color on_secondary_fixed_variant:  null
    property color on_surface:  null
    property color on_surface_variant:  null
    property color on_tertiary:  null
    property color on_tertiary_container:  null
    property color on_tertiary_fixed:  null
    property color on_tertiary_fixed_variant: null
    property color outline:  null
    property color outline_variant:  null
    property color primary:  null
    property color primary_container:  null
    property color primary_fixed:  null
    property color primary_fixed_dim: null
    property color scrim:  null
    property color secondary:  null
    property color secondary_container:  null
    property color secondary_fixed:  null
    property color secondary_fixed_dim:  null
    property color shadow:  null
    property color surface:  null
    property color surface_bright:  null
    property color surface_container:  null
    property color surface_container_high:  null
    property color surface_container_highest:  null
    property color surface_container_low: null
    property color surface_container_lowest:  null
    property color surface_dim:  null
    property color surface_variant:  null
    property color tertiary:  null
    property color tertiary_container:  null
    property color tertiary_fixed:  null
    property color tertiary_fixed_dim:  null
    property color source_color: null


    FileView {
        id: jsonFile
        path: Qt.resolvedUrl("colors.json")

        // Forces the file to be loaded by the time we call JSON.parse().
        // See blockLoading's property documentation for details.
        watchChanges: true
        blockLoading: false

        onLoaded: {
            const colors_object = JSON.parse(jsonFile.text())

            colors.error = colors_object.error;
            colors.error_container = colors_object.error_container;
            colors.inverse_on_surface = colors_object.inverse_on_surface;
            colors.inverse_primary = colors_object.inverse_primary;
            colors.inverse_surface = colors_object.inverse_surface;
            colors.on_background = colors_object.on_background;
            colors.on_error = colors_object.on_error;
            colors.on_error_container = colors_object.on_error_container;
            colors.on_primary = colors_object.on_primary;
            colors.on_primary_container = colors_object.on_primary_container;
            colors.on_primary_fixed = colors_object.on_primary_fixed;
            colors.on_primary_fixed_variant = colors_object.on_primary_fixed_variant;
            colors.on_secondary = colors_object.on_secondary;
            colors.on_secondary_container = colors_object.on_secondary_container;
            colors.on_secondary_fixed = colors_object.on_secondary_fixed;
            colors.on_secondary_fixed_variant = colors_object.on_secondary_fixed_variant;
            colors.on_surface = colors_object.on_surface;
            colors.on_surface_variant = colors_object.on_surface_variant;
            colors.on_tertiary = colors_object.on_tertiary;
            colors.on_tertiary_container = colors_object.on_tertiary_container;
            colors.on_tertiary_fixed = colors_object.on_tertiary_fixed;
            colors.on_tertiary_fixed_variant = colors_object.on_tertiary_fixed_variant;
            colors.outline = colors_object.outline;
            colors.outline_variant = colors_object.outline_variant;
            colors.primary = colors_object.primary;
            colors.primary_container = colors_object.primary_container;
            colors.primary_fixed = colors_object.primary_fixed;
            colors.primary_fixed_dim = colors_object.primary_fixed_dim;
            colors.scrim = colors_object.scrim;
            colors.secondary = colors_object.secondary;
            colors.secondary_container = colors_object.secondary_container;
            colors.secondary_fixed = colors_object.secondary_fixed;
            colors.secondary_fixed_dim = colors_object.secondary_fixed_dim;
            colors.shadow = colors_object.shadow;
            colors.surface = colors_object.surface
            colors.surface_bright = colors_object.surface_bright;
            colors.surface_container = colors_object.surface_container;
            colors.surface_container_high = colors_object.surface_container_high;
            colors.surface_container_highest = colors_object.surface_container_highest;
            colors.surface_container_low = colors_object.surface_container_low;
            colors.surface_container_lowest = colors_object.surface_container_lowest;
            colors.surface_dim = colors_object.surface_dim;
            colors.surface_variant = colors_object.surface_variant;
            colors.tertiary = colors_object.tertiary;
            colors.tertiary_container = colors_object.tertiary_container;
            colors.tertiary_fixed = colors_object.tertiary_fixed;
            colors.tertiary_fixed_dim = colors_object.tertiary_fixed_dim;

            colors.colorsChanged()
        }

        onFileChanged: {
            console.log("File changed, reloading...");
            jsonFile.reload();
        }

    }

}
