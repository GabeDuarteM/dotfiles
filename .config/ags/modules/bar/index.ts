const myLabel = Widget.Label({
  label: "some example content",
});

export const Bar = (monitor = 0) =>
  Widget.Window({
    className: "foo",
    name: `bar${monitor}`,
    monitor,
    anchor: ["top", "left", "right"],
    child: myLabel,
  });
