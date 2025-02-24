import { Variable } from "astal";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { hyprland_session, screen_width } from "../../../../globals";
import { Gtk } from "astal/gtk4";
import Indicator from "./Indicator";

function get_workspaces() {
  let sorted_workspaces: AstalHyprland.Workspace[] = [];
  const workspaces = hyprland_session.get_workspaces();
  workspaces.forEach((workspace) => {
    const workspace_id = workspace.get_id();
    if (workspace_id != -99) sorted_workspaces[workspace_id] = workspace;
  });
  return sorted_workspaces;
}

const workspaceIndicators: Gtk.Widget[] | null[] = [];

export default () => (
  <box
    cssClasses={["workspace-display", "container", "container-margin"]}
    valign={Gtk.Align.CENTER}
    setup={(self) => {
      hyprland_session.connect("workspace-added", (_, workspace) => {
        if (workspace.get_id() != -99) {
          const workspace_id = workspace.get_id();
          const workspace_name = workspace_id.toString();
          const workspace_indicator = (
            <Indicator
              workspace_name={workspace_name}
              workspace_id={workspace_id}
            />
          );
          workspaceIndicators[workspace_id] = workspace_indicator;
          self.append(workspace_indicator);
        }
      });

      hyprland_session.connect("workspace-removed", (_, workspace_id) => {
        self.remove(workspaceIndicators[workspace_id]!);
        workspaceIndicators[workspace_id] = null;
      });

      const workspaces = get_workspaces();
      workspaces.forEach((workspace) => {
        const workspace_id = workspace.get_id();
        const workspace_name = workspace_id.toString();
        const workspace_indicator = (
          <Indicator
            workspace_name={workspace_name}
            workspace_id={workspace_id}
          />
        );
        workspaceIndicators[workspace_id] = workspace_indicator;
        self.append(workspace_indicator);
      });
    }}
  />
);
