import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./widgets/Bar/Bar";
import { setup_css } from "./widgets/globals/utilities";
import Switcher from "./widgets/Switcher/Switcher";
import {
  request_cycle_next,
  request_switch_window,
} from "./widgets/Switcher/switcher_daemon";
import Corners from "./widgets/Corners/Corners";
import daemon_start from "./widgets/globals/color_daemon";

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
    setup_css();
    daemon_start();

    Bar(0);
    Switcher();
    App.get_monitors().map(Corners);
  },
});
