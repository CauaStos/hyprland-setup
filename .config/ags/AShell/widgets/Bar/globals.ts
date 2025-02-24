import { App } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";

export const hyprland_session = AstalHyprland.get_default();
const monitoractive = hyprland_session.get_focused_monitor();
export const screen_width = monitoractive.get_width();
export const screen_height = monitoractive.get_height();
export function apply_resolution_to_css() {
  App.apply_css(`
    :root{
    --screen-width: ${screen_width}px;
    --screen-height: ${screen_height}px;
    }
    `);
  App.apply_css("~/.config/ags/globals.scss");
}
