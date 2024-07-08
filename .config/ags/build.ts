import { bundle } from "lightningcss";

const filename = __dirname + "/main.css";

let { code } = bundle({
  filename,
});

await Bun.write("/tmp/ags/css/main.css", code);
