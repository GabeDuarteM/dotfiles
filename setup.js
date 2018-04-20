const { join, basename } = require("path")
const { existsSync, ensureDirSync, moveSync, symlinkSync } = require("fs-extra")
const { execFileSync } = require("child_process")
const { createInterface } = require("readline")
const { homedir } = require("os")

const cygPath = execFileSync("cygpath", ["-w", "~"])
  .toString()
  .trim()

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
})

const COLORS = {
  RESET: "\x1b[0m",
  CYAN: "\x1b[36m",
}

const CYGWIN = "CYGWIN"
const HOME = "HOME"

const logResponse = text => console.log(COLORS.CYAN, "~", COLORS.RESET, text)

rl.question(
  `Is '${cygPath}' the correct path for cygwin? [y/N] `,
  cygAnswer => {
    if (negativeResponse(cygAnswer)) {
      rl.close()

      return
    }

    logResponse("Yes.")

    rl.question(
      `Is '${homedir()}' the home path of this user? [y/N] `,
      homeAnswer => {
        if (negativeResponse(homeAnswer)) {
          rl.close()

          return
        }

        FILES.forEach(file => {
          if (file.linkTo.includes(CYGWIN)) {
            createLink(file, cygPath, CYGWIN)
          }

          if (file.linkTo.includes(HOME)) {
            createLink(file, homedir(), HOME)
          }
        })

        rl.close()
      },
    )
  },
)

const createLink = (file, dir, type) => {
  const linkFile = join(dir, basename(file.path))
  const originalFile = join(__dirname, file.path)

  if (existsSync(linkFile)) {
    const backupDir = join(__dirname, ".backup", type)
    console.log(
      "File '%s' already exists. Moving it to '%s'",
      linkFile,
      backupDir,
    )
    const filename = basename(originalFile)

    ensureDirSync(backupDir)

    moveSync(linkFile, join(backupDir, filename))
  }

  symlinkSync(originalFile, linkFile)

  console.log("Symbolic link created for file %s", linkFile)
}

const negativeResponse = (answer, rl) => {
  if (!answer || answer.toLowerCase() === "n") {
    logResponse("No.")

    return true
  }

  if (!["n", "y"].includes(answer.toLowerCase())) {
    logResponse(answer)
    console.log("Invalid option.")

    return true
  }

  return false
}

const FILES = [
  { path: "files/zsh/.bash_profile", linkTo: [CYGWIN] },
  { path: "files/zsh/.bashrc", linkTo: [CYGWIN] },
  { path: "files/zsh/.profile", linkTo: [CYGWIN] },
  { path: "files/zsh/.zpreztorc", linkTo: [CYGWIN] },
  { path: "files/zsh/.zshrc", linkTo: [CYGWIN] },
  { path: "files/.czrc", linkTo: [HOME] },
  { path: "files/.gitconfig", linkTo: [HOME, CYGWIN] },
  { path: "files/.hyper.js", linkTo: [HOME] },
]
