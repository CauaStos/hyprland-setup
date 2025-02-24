import { App, astalify, Gtk } from "astal/gtk4";
import {
  previousSwitcherClients,
  switcherClients,
  switcherPosition,
} from "../switcher_daemon";
import { Label } from "astal/gtk4/widget";
import WindowPreview from "./WindowPreview";

const flow_box = astalify(Gtk.FlowBox);
export default () =>
  flow_box({
    cssClasses: ["grid"],
    setup: (self) => {
      self.set_min_children_per_line(3);
      self.set_max_children_per_line(3);
      self.set_orientation(0);
      self.vexpand = false;
      self.hexpand = false;
      switcherClients.subscribe((clients) => {
        let past_clients = previousSwitcherClients.get();
        let current_clients = switcherClients.get();
        let past_client_length = past_clients.length;
        let client_length = current_clients.length;
        //Don't trigger unecessary re-renders.
        if (
          past_client_length != client_length ||
          past_clients[0].get_title() != current_clients[0].get_title()
        ) {
          print("re-rendered");
          self.remove_all();
          for (let i = 0; i < clients.length; i++) {
            //Why a normal for instead of foreach?
            let client_title = clients[i].get_initial_title();
            if (client_title.length > 13)
              client_title = client_title.substring(0, 10) + "...";
            const client_class = clients[i].get_class();
            const client_thumbnail = clients[i].get_pid().toString();
            const client_focus_history_id = i; //AstalHyprland.Client focus_history_id doesn't get updated when a client is added/removed. Have to pass array index to have accurate order.
            self.append(
              <WindowPreview
                window_name={client_title}
                window_class={client_class}
                window_thumbnail={client_thumbnail}
                window_focus_history_id={client_focus_history_id}
              />,
            );
          }
        }
      });
    },
  });
