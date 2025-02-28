import { Gtk } from "astal/gtk4";
import Display from "./Workspace Display/Display";
import { hyprland_session } from "../../../globals/utilities";
import { bind, exec } from "astal";
import Information from "./Information";

export default () => {
  return (
    <box
      cssClasses={["workspace"]}
      halign={Gtk.Align.START}
      valign={Gtk.Align.CENTER}
    >
      <Information />
      <Display />
    </box>
  );
};
