import { bind } from "astal";
import { hyprland_session } from "../../../../globals/utilities";
import { Gtk } from "astal/gtk4";

interface Props {
  workspace_id: number;
  workspace_name: string;
}

export default (props: Props) => {
  return (
    <label
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      cssClasses={bind(hyprland_session, "focusedWorkspace").as((workspace) => {
        const workspace_common = [
          "workspace",
          "round",
          "h5",
          "text-on-primary",
        ];
        return workspace.id.toString() == props.workspace_name
          ? [...workspace_common, "workspace-active", "background-on-primary"]
          : [...workspace_common, "workspace-inactive", "background-primary"];
      })}
      setup={(self) => (props.workspace_id > 1 ? self.set_xalign(0.55) : "")}
    >
      {props.workspace_name}
    </label>
  );
};
