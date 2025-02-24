import { Gtk } from "astal/gtk4";
import Display from "./Display";
import { hyprland_session } from "../../../../globals";
import { bind, exec } from "astal";

export default () => {
  return (
    <box
      cssClasses={["session-info"]}
      halign={Gtk.Align.START}
      valign={Gtk.Align.CENTER}
    >
      <box cssClasses={["information"]} orientation={Gtk.Orientation.VERTICAL}>
        <label
          cssClasses={["name", "h4"]}
          label={exec("bash -c 'echo $(whoami)@$(hostnamectl hostname)'")}
        />
        <label
          cssClasses={["workspace", "h3"]}
          label={bind(hyprland_session, "focusedWorkspace").as((workspace) => {
            const workspace_name = workspace.get_id();
            const text = `Workspace ${workspace_name}`;
            return text;
          })}
        />
      </box>
      <Display />
    </box>
  );
};
