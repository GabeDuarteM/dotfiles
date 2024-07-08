const time = Variable("", {
  poll: [
    1000,
    function () {
      return Date().toString();
    },
  ],
});

const notifications = await Service.import("notifications");
notifications.popupTimeout = 3000;
notifications.forceTimeout = false;
notifications.cacheActions = false;
notifications.clearDelay = 100;

const systemtray = await Service.import("systemtray");

/** @param {import('types/service/systemtray').TrayItem} item */
const SysTrayItem = (item) =>
  Widget.Button({
    child: Widget.Icon().bind("icon", item, "icon"),
    tooltipMarkup: item.bind("tooltip_markup"),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
  });

const sysTray = Widget.Box({
  children: systemtray.bind("items").as((i) => i.map(SysTrayItem)),
});

const Bar = (monitor: number) =>
  Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: sysTray,
      end_widget: Widget.Label({
        hpack: "center",
        label: time.bind(),
      }),
    }),
  });

App.config({
  windows: [Bar(1), Bar(0)],
});
