import { exec, execAsync, Gio, GLib, interval, Variable } from "astal";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { App, Gdk } from "astal/gtk4";
import { hyprland_session } from "./globals";

class SwitcherPosition extends Variable<number> {
  constructor() {
    super(-1);
  }

  previous() {
    this.set(this.get() - 1);
    if (this.get() <= 0) this.clear();
  }

  next() {
    this.set(this.get() + 1);
    if (this.get() >= switcherClients.get().length) this.clear();
  }

  clear() {
    this.set(0);
  }

  setup() {
    this.set(-1);
  }
}

interface ClientInfo extends Object {
  class: string;
  title: string;
  initialClass: string;
  initialTitle: string;
  focusHistoryID: number;
  pid: number;
  at: [number, number];
  size: [number, number];
  fullscreen: number;
}

class Client {
  private class;
  private title;
  private initialClass;
  private initialTitle;
  private focusHistoryID;
  private pid;
  private x;
  private y;
  private width;
  private height;
  private fullscreen;
  constructor(client_info: ClientInfo) {
    this.class = client_info.class;
    this.title = client_info.title;
    this.initialClass = client_info.initialClass;
    this.initialTitle = client_info.initialTitle;
    this.focusHistoryID = client_info.focusHistoryID;
    this.pid = client_info.pid;
    this.x = client_info.at[0];
    this.y = client_info.at[1];
    this.width = client_info.size[0];
    this.height = client_info.size[1];
    this.fullscreen = client_info.fullscreen;
  }
  get_class(): string {
    return this.class;
  }

  get_title(): string {
    return this.title;
  }

  get_initial_class(): string {
    return this.initialClass;
  }

  get_initial_title(): string {
    return this.initialTitle;
  }

  get_focus_history_id(): number {
    return this.focusHistoryID;
  }

  get_pid(): number {
    return this.pid;
  }

  get_x(): number {
    return this.x;
  }

  get_y(): number {
    return this.y;
  }

  get_width(): number {
    return this.width;
  }

  get_height(): number {
    return this.height;
  }

  is_fullscreen(): boolean {
    return this.fullscreen == 0 || this.fullscreen == 1 ? true : false;
  }
}

function get_clients() {
  const hyprctl_clients = exec("hyprctl clients -j");
  const json: ClientInfo[] = JSON.parse(hyprctl_clients);
  let clients: Client[] = [];
  json.forEach((entry) => clients.push(new Client(entry)));
  return clients;
}

function load_clients() {
  const clients = get_clients();
  let sorted_clients = sort_clients(clients);
  print(sorted_clients);
  switcherClients.set(sorted_clients);
}

function sort_clients(clients: Client[]) {
  const sorted_clients: Client[] = [];
  const focus_sorted_clients: Client[] = [];
  const clients_map = clients.map((client) => client);

  clients_map.forEach((client) => {
    focus_sorted_clients[client.get_focus_history_id()] = client;
  });

  //Second foreach is done because when you minimize an app to the tray, the client in focus_sorted_clients becomes undefined.
  focus_sorted_clients.forEach((client) => {
    if (client) sorted_clients.push(client);
  });
  return sorted_clients;
}

function cycle_next() {
  run_service();
  switcherVisible.set(true);
  switcherPosition.next();
}

export function request_cycle_next() {
  try {
    cycle_next();
    return "Cycled to next window.";
  } catch (error) {
    return `Error: ${error}`;
  }
}

export function request_switch_window() {
  if (switcherVisible.get())
    try {
      switch_window();
      return "Switched to window.";
    } catch (error) {
      return `Error: ${error}`;
    }
  return "Switcher is not active. Will not switch window.";
}
function switch_window() {
  //hyprctl dispatch focuswindow pid:(pidhere)
  const clients = switcherClients.get();
  const client = clients[switcherPosition.get()];
  const pid = client.get_pid();
  hyprland_session.dispatch("focuswindow", `pid:${pid}`);
  switcherVisible.set(false);
  switcherPosition.clear();
}

function run_service() {
  if (!isFirstRun) previousSwitcherClients.set(switcherClients.get());
  load_clients();

  if (isFirstRun) {
    isFirstRun = false;
    previousSwitcherClients.set(switcherClients.get());
  }
}

//variables
let isFirstRun = true;

//hooks
export const previousSwitcherClients = Variable<Client[]>([]);
export const switcherClients = Variable<Client[]>([]);
export const switcherVisible = Variable(false);
export const switcherPosition = new SwitcherPosition();
export const focusedMonitor = Variable(
  AstalHyprland.get_default().get_monitor(0),
);
//signals
hyprland_session.connect("client-added", () => {
  load_clients();
  switcherPosition.previous();
});

hyprland_session.connect("client-removed", () => {
  load_clients();
  switcherPosition.previous();
});
