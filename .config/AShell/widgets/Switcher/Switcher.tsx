import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { switcherVisible } from "./switcher_daemon";
import Grid from "./components/Grid";
import GdkWayland from "gi://GdkWayland?version=4.0";

export default () => {
  return (
    <window
      application={App}
      title="Switcher"
      namespace="AShell"
      layer={Astal.Layer.OVERLAY}
      visible={switcherVisible((value) => value)}
      css_classes={["window-switcher", "background-surface"]}
      resizable={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      monitor={0}
      keymode={0}
    >
      <Grid />
    </window>
  );
};
