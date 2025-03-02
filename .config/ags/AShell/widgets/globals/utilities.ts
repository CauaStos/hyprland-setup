import { exec, execAsync, monitorFile, readFile, Variable } from "astal";
import { App } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import GLib from "gi://GLib?version=2.0";

//variables
export const hyprland_session = AstalHyprland.get_default();
const activemonitor = hyprland_session.get_focused_monitor();
export const screen_width = activemonitor.get_width();
export const screen_height = activemonitor.get_height();

const home = GLib.get_home_dir();

const colors_path = `${home}/.config/ags/AShell/config/colors.json`;
const colors_json = readFile(colors_path);
const colors_object = JSON.parse(colors_json);
export const colorConfig = new Variable<Record<string, string>>(colors_object);

//functions
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

export function get_color(color: string) {}

export function apply_colors_to_css() {
  const home = GLib.get_home_dir();
  const colors = colorConfig.get();

  let css_colors = "";
  for (let key in colors) {
    css_colors += `--${key}: ${colors[key]}; `;
  }
  console.log(`
    :root{
    ${css_colors}
   }
    `);

  App.apply_css(`
    :root{
    ${css_colors}
   }
    `);
  colorConfig;
}

//listeners

monitorFile(colors_path, (color_path) => {
  const colors_json = readFile(color_path);
  const colors_object = JSON.parse(colors_json);
  colorConfig.set(colors_object);
  apply_colors_to_css();
});
