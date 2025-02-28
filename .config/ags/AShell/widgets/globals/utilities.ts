import { exec, execAsync } from "astal";
import { App } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import GLib from "gi://GLib?version=2.0";

export const hyprland_session = AstalHyprland.get_default();

const activemonitor = hyprland_session.get_focused_monitor();

export const screen_width = activemonitor.get_width();
export const screen_height = activemonitor.get_height();

export function setup_css() {
  apply_resolution_to_css();
  apply_colors_to_css();
}

export function apply_resolution_to_css() {
  App.apply_css(`
    :root{
    --screen-width: ${screen_width}px;
    --screen-height: ${screen_height}px;
    }
    `);
}

export function apply_colors_to_css() {
  const home = GLib.get_home_dir();
  exec(`sass ${home}/.config/ags/AShell/config/colors.css /tmp/result.css`);
  App.apply_css("/tmp/result.css");
  App.apply_css("~/.config/ags/AShell/config/colors.css");
}
