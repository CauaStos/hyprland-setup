import Gtk from "gi://Gtk?version=4.0";
import { hyprland_session } from "../../../globals/utilities";
import { bind, exec } from "astal";

export default () => {
  return (
    <box
      cssClasses={["container", "information"]}
      orientation={Gtk.Orientation.VERTICAL}
    >
      <label
        cssClasses={["machine-info", "h4", "text-on-surface"]}
        label={exec("bash -c 'echo $(whoami)@$(hostnamectl hostname)'")}
        halign={Gtk.Align.START}
      />
      <label
        cssClasses={["workspace-name", "h3", "text-primary"]}
        label={bind(hyprland_session, "focusedWorkspace").as((workspace) => {
          const workspace_name = workspace.get_id();
          const text = `Workspace ${workspace_name}`;
          return text;
        })}
        halign={Gtk.Align.START}
      />
    </box>
  );
};
