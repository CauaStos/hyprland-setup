import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./widgets/Bar/Bar";
import Corners from "./widgets/Bar/components/Corners/Corners";
import { apply_resolution_to_css } from "./globals";
import Switcher from "./widgets/Switcher/Switcher";
import {
  request_cycle_next,
  request_switch_window,
} from "./widgets/Switcher/switcher_daemon";

App.start({
  instanceName: "AShell",
  requestHandler(request: string, res: (Response: any) => void) {
    let result_message: string;
    switch (request) {
      case "cycle_next":
        result_message = request_cycle_next();
        return res(result_message);
      case "switch_window":
        result_message = request_switch_window();
        return res(result_message);
    }
    res("Unknown");
  },
  css: style,
  main() {
    Bar(0);
    App.get_monitors().map(Corners);
    Switcher();
    apply_resolution_to_css();
  },
});
