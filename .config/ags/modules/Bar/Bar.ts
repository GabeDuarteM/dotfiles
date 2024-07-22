import { DEFAULT_MONITOR } from "modules/consts.js";
import type { Workspace } from "types/service/hyprland.js";

const hyprland = await Service.import("hyprland");
// const notifications = await Service.import("notifications");
// const mpris = await Service.import("mpris");
const systemtray = await Service.import("systemtray");

const date = Variable("", {
  poll: [1000, 'date "+%b %e/%m %H:%M"'],
});

// Temporary until we migrate from eww completely
const CallEwwModule = (module: string, monitor = DEFAULT_MONITOR) => {
  const closerResponse = Utils.exec(
    `eww open ${module}-closer --toggle --screen ${monitor}`,
  );

  const moduleResponse = Utils.exec(
    `eww open ${module} --toggle --screen ${monitor}`,
  );

  console.log(
    `Eww module invoked: ${module}. Response: ${moduleResponse}. Closer: ${closerResponse}`,
  );

  return module;
};

const SPECIAL_WORKSPACE = "special:magic";

function Workspaces(currentMonitor = DEFAULT_MONITOR) {
  const workspaces = hyprland.bind("workspaces").as((ws: Workspace[]) =>
    ws
      .filter(
        ({ monitorID, name }) =>
          monitorID === currentMonitor + 1 && name !== SPECIAL_WORKSPACE,
      )
      .toSorted((a, b) => a.id - b.id)
      .map(({ id }) => {
        const label = id >= 11 ? id - 10 : id;

        return Widget.Button({
          on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
          child: Widget.Label(`${label}`),
          className: "workspace",
          setup: (self) =>
            self.hook(hyprland, () => {
              self.toggleClassName(
                "active",
                hyprland.active.workspace.id === id,
              );
            }),
        });
      }),
  );

  return Widget.Box({
    className: "island",
    children: workspaces,
  });
}

function ClientTitle() {
  const title = hyprland.active.client.bind("title").as((t) => {
    const maxLength = 50;

    return `${t.substring(0, maxLength)}${t.length > maxLength ? "[...]" : ""}`;
  });

  return Widget.Label({
    className: "island",
    visible: title.as((t) => t !== ""),
    label: title,
    setup: (self) =>
      self.hook(hyprland, () => {
        self.visible = hyprland.active.client.title !== "";
      }),
  });
}

function Clock(monitor = DEFAULT_MONITOR) {
  return Widget.Button({
    className: "clock",
    label: date.bind(),
    on_clicked: () => CallEwwModule("calendar", monitor),
  });
}

// // we don't need dunst or any other notification daemon
// // because the Notifications module is a notification daemon itself
// function Notification() {
//   const popups = notifications.bind("popups");
//   return Widget.Box({
//     className: "notification",
//     visible: popups.as((p) => p.length > 0),
//     children: [
//       Widget.Icon({
//         icon: "preferences-system-notifications-symbolic",
//       }),
//       Widget.Label({
//         label: popups.as((p) => p[0]?.summary || ""),
//       }),
//     ],
//   });
// }

// function Media() {
//   const label = Utils.watch("", mpris, "player-changed", () => {
//     if (mpris.players[0]) {
//       const { track_artists, track_title } = mpris.players[0];
//       return `${track_artists.join(", ")} - ${track_title}`;
//     } else {
//       return "Nothing is playing";
//     }
//   });
//
//   return Widget.Button({
//     className: "media",
//     on_primary_click: () => mpris.getPlayer("")?.playPause(),
//     on_scroll_up: () => mpris.getPlayer("")?.next(),
//     on_scroll_down: () => mpris.getPlayer("")?.previous(),
//     child: Widget.Label({ label }),
//   });
// }

function SysTray(monitor = DEFAULT_MONITOR) {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        className: "sys-tray-item",
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    children: items,
    className: "sys-tray",
  });
}

function Left(monitor = DEFAULT_MONITOR) {
  return Widget.Box({
    children: [Workspaces(monitor)],
  });
}

function Center(monitor = DEFAULT_MONITOR) {
  return Widget.Box({
    spacing: 8,
    children: [ClientTitle()],
  });
}

function Right(monitor = DEFAULT_MONITOR) {
  return Widget.Box({
    hpack: "end",
    className: "island",
    spacing: 8,
    children: [SysTray(monitor), Clock(monitor)],
  });
}

export function Bar(monitor = DEFAULT_MONITOR) {
  return Widget.Window({
    name: `bar-${monitor}`,
    className: "bar-container",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      className: "bar",
      start_widget: Left(monitor),
      center_widget: Center(monitor),
      end_widget: Right(monitor),
    }),
  });
}
