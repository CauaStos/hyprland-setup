let position = 0;
var window_length = 0;

let clients = [];

function send_message(message, data = "") {
  WorkerScript.sendMessage({ message: message, data: data });
}

function next() {
  position >= window_length - 1 ? (position = 0) : position++;
}

function clear_position() {
  position = 0;
}

function sort_clients() {
  const focus_sorted_clients = [];

  clients.forEach((client, index) => {
    client.arrayIndex = index;
    focus_sorted_clients[client.focusHistoryID] = client;
  });

  clients = focus_sorted_clients;
}

function switch_window() {}

WorkerScript.onMessage = function (message) {
  switch (message.message) {
    case "next":
      next();
      send_message("update_position", position);
      break;
    case "update_clients":
      clients = message.clients;
      window_length = message.clients.length;
      position = 0;
      sort_clients();
      send_message("update_clients", clients);
      send_message("update_position", position);
      break;
  }
};
