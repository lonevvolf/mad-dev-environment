# Connect interactive VS Code R sessions to the workspace and plot viewers.
if (interactive() && Sys.getenv("TERM_PROGRAM") == "vscode") {
  local({
    init <- path.expand("~/.vscode-R/init.R")
    if (file.exists(init)) source(init)
  })
}
