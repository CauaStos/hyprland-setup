import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable } from "astal";
import Workspace from "./components/Workspace/Workspace";
import Date from "./components/Date/Date";
import Island from "./components/Island/Island";

export default function Bar(monitor: number) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      monitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
      namespace={"AShell"}
      defaultWidth={1} //FIXES SHRINKING BUG
      defaultHeight={1} //FIXEs SHRINKING BUG THANK GOD
      cssClasses={["background-surface", "Bar"]}
    >
      <centerbox>
        <box halign={Gtk.Align.START}>
          <Workspace />
        </box>
        <box>
          <Date />
          <Island />
        </box>
      </centerbox>
    </window>
  );
}
