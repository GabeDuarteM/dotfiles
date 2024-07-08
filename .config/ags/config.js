const entry = App.configDir + "/main.ts";
const outdir = "/tmp/ags/js";

const colorizeError = (/** @type {string} */ msg) => {
  const RED = "\x1b[31m";
  const RESET = "\x1b[0m";
  return `${RED}${msg}${RESET}`;
};

try {
  //  bunx sass --no-source-map main.scss /tmp/main.css
  await Utils.execAsync([
    "bunx",
    "sass",
    "--no-source-map",
    "main.scss",
    "/tmp/ags/css/main.css",
  ]).then((/** @type {string} */ out) => print(out));

  await Utils.execAsync([
    "bun",
    "build",
    entry,
    "--outdir",
    outdir,
    "--external",
    "resource://*",
    "--external",
    "gi://*",
  ]).then((out) => print(out));
  await import(`file://${outdir}/main.js`);
} catch (error) {
  print(
    colorizeError(
      " >>>>>>>>>>                                    <<<<<<<<<<\n",
    ),
    colorizeError(">>>>>>>>>> There was an error while building. <<<<<<<<<<\n"),
    colorizeError(">>>>>>>>>>                                    <<<<<<<<<<"),
  );
  console.error(error);
  print(
    colorizeError(
      " >>>>>>>>>>                                    <<<<<<<<<<\n",
    ),
    colorizeError(">>>>>>>>>>                                    <<<<<<<<<<\n"),
    colorizeError(">>>>>>>>>>                                    <<<<<<<<<<"),
  );
}
