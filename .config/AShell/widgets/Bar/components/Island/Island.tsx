import { Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Idle from "./widgets/Idle";

export const isIslandIdle = Variable(true);

export default () => {
  return <box>{<Idle />}</box>;
};
