import { Bar } from "modules/Bar/Bar.js";
import { Media } from "modules/Media/Media.js";
// import NotificationPopups from "modules/Notification/Notification.js";
import { NotificationPopups } from "modules/Notification/Notification2.js";

App.config({
  style: "/tmp/ags/css/main.css",
  windows: [
    Bar(0),
    Bar(1),
    Media(0),
    NotificationPopups()
  ],
});
