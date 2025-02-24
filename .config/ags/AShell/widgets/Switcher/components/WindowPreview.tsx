import { exec, GLib, monitorFile, subprocess } from "astal";
import { App, astalify, Gdk, Gtk } from "astal/gtk4";
import { Box, Image } from "astal/gtk4/widget";
import AstalIO from "gi://AstalIO?version=0.1";
import {
  focusedMonitor,
  switcherClients,
  switcherPosition,
} from "../switcher_daemon";
import Gio from "gi://Gio?version=2.0";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import GdkPixbuf from "gi://GdkPixbuf?version=2.0";

interface Props {
  window_name: string;
  window_class: string;
  window_thumbnail: string;
  window_focus_history_id: number;
}

function lookup_icon(icon_name: string) {
  //grep -i "Icon=" /usr/share/applications
  let icon;
  //Does two searches for icons. One with a case-sensitive file name and one on lowercase.
  try {
    const icon_search = exec(
      `grep -i "Icon=" /usr/share/applications/${icon_name}.desktop `,
    );

    icon = icon_search.replace("Icon=", "");
  } catch (error) {
    try {
      const icon_search = exec(
        `grep -i "Icon=" /usr/share/applications/${icon_name.toLowerCase()}.desktop `,
      );
      icon = icon_search.replace("Icon=", "");
    } catch (error) {
      return null;
    }
  }
  return icon;
}

const Picture = astalify(Gtk.Picture);
const Fixed = astalify(Gtk.Fixed);
const FlowBoxChildren = astalify(Gtk.FlowBoxChild);
export default (props: Props) => {
  const icon_by_windowname = lookup_icon(props.window_name);
  const icon_by_windowclass = lookup_icon(props.window_class);

  return (
    <FlowBoxChildren onDestroy={(self) => self.get_parent()?.queue_allocate()}>
      <Box
        cssClasses={switcherPosition((position) =>
          position == props.window_focus_history_id
            ? ["window-preview", "window-selected"]
            : ["window-preview"],
        )}
        orientation={1}
      >
        <label
          cssClasses={["title"]}
          label={props.window_name}
          setup={(self) => {
            const container_height = focusedMonitor.get().height * 0.15;
            self.heightRequest = container_height * 0.3;
            focusedMonitor.subscribe((callback) => {
              const container_height = focusedMonitor.get().height * 0.15;
              self.heightRequest = container_height * 0.3;
            });
          }}
        />
        <Image
          cssClasses={["icon"]}
          iconName={
            icon_by_windowclass ? icon_by_windowclass : icon_by_windowname!
          }
          setup={(self) => {
            const container_height = focusedMonitor.get().height * 0.15;
            self.set_pixel_size(container_height * 0.7);
            focusedMonitor.subscribe((callback) => {
              const container_height = focusedMonitor.get().height * 0.15;
              self.set_pixel_size(container_height * 0.8);
            });
          }}
        />
      </Box>
    </FlowBoxChildren>
  );
};
