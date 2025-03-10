import { GLib, Variable } from "astal";
import Gtk from "gi://Gtk?version=4.0";
import SeparatorText from "../../../globals/components/SeparatorText";
import { isIslandIdle } from "../Island/Island";

interface Props {
  island_mode?: boolean;
}

export default (props: Props) => {
  const time = new Variable(
    <SeparatorText text_after="Time's" text_before="Broken" />,
  ).poll(1000, () => {
    const time = GLib.DateTime.new_now_local();

    const time_before_dot = time.format("%H:%M");

    const time_after_dot = props.island_mode
      ? time.format("%d/%m")
      : time.format("%A, %d/%m");

    return (
      <SeparatorText
        text_before={time_before_dot!}
        text_after={time_after_dot!}
        text_classes={["h5", "text-on-surface"]}
        separator_classes={["h5", "text-primary"]}
      />
    );
  });

  return (
    <box
      cssClasses={isIslandIdle((isIdle) =>
        isIdle
          ? ["background-surface-container", "round", "disabled"]
          : [
              "background-surface-container",
              "round",
              "container",
              "date",
              props.island_mode ? "" : "container-extra-horizontal-padding",
            ],
      )}
      halign={Gtk.Align.END}
      valign={Gtk.Align.CENTER}
      overflow={Gtk.Overflow.HIDDEN}
    >
      {time()}
    </box>
  );
};
