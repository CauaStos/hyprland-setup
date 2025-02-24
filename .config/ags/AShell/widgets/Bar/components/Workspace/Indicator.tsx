import { bind } from "astal";
import { hyprland_session } from "../../../../globals";
import { Gtk } from "astal/gtk4";

interface Props {
  workspace_id: number;
  workspace_name: string;
}

export default (props: Props) => {
  return (
    <box
      cssClasses={bind(hyprland_session, "focusedWorkspace").as((workspace) => {
        return workspace.id.toString() == props.workspace_name
          ? ["workspace-inactive", "workspace-active", "inner-container-margin"]
          : ["workspace-inactive", "inner-container-margin"];
      })}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      hexpand={false}
      vexpand={false}
    >
      <label
        hexpand={true} // found how to center it !!! lol
        halign={Gtk.Align.CENTER}
        cssClasses={["h5", "inner-container"]}
        setup={(self) => {
          if (props.workspace_id != 1) {
            self.set_xalign(0.55);
          }
        }}
        label={props.workspace_name}
      />
    </box>
  );
};
