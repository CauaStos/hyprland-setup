import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable } from "astal";
import Workspace from "./components/Workspace/Workspace";

const time = Variable("").poll(1000, "date");

export default function Bar(monitor: number) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssClasses={["Bar"]}
      monitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
      //wildcard is resizable={true}
      //prolly not gonna use it.
    >
      <box>
        <Workspace />
      </box>
    </window>
  );
}
