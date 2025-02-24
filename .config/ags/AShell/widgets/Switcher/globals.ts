import { App } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";

export const hyprland_session = AstalHyprland.get_default();

export function apply_resolution_to_css() {
  const monitoractive = hyprland_session.get_focused_monitor();
  const screen_width = monitoractive.get_width();
  const screen_height = monitoractive.get_height();
  App.apply_css(`
    :root{
    --screen-width: ${screen_width}px;
    --screen-height: ${screen_height}px;
    }
    `);
}
