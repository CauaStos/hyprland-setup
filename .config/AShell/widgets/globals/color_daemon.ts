import { GLib, monitorFile } from "astal";
import { apply_colors_to_css } from "./utilities";

export function get_color(color_name: string) {}

export default function daemon_start() {
  const home = GLib.get_home_dir();
  //Css colors listener
  monitorFile(`${home}/.config/AShell/config/colors.css`, () => {
    apply_colors_to_css();
  });
}
