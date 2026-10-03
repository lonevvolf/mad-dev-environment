# Install the stable graphics device; vscode-R manages its bundled sess package.
repos <- c(CRAN = "https://cloud.r-project.org")
user_library <- path.expand(Sys.getenv("R_LIBS_USER"))
if (!nzchar(user_library)) stop("R_LIBS_USER must name the user package library")
dir.create(user_library, recursive = TRUE, showWarnings = FALSE)
.libPaths(c(user_library, .libPaths()))
if (!requireNamespace("jgd", quietly = TRUE)) {
  install.packages("jgd", repos = repos, lib = user_library)
}
stopifnot(requireNamespace("jgd", quietly = TRUE))
message("jgd ", packageVersion("jgd"), " available")

# Earlier containers copied this exact profile into the persisted home directory.
# Back it up only when it is unchanged; preserve custom user profiles.
legacy_profile <- "if (interactive() && requireNamespace(\"httpgd\", quietly = TRUE)) {\n  options(device = function(...) {\n    httpgd::hgd(..., silent = TRUE)\n    httpgd::hgd_browse()\n  })\n}\n"
profile <- path.expand("~/.Rprofile")
if (file.exists(profile)) {
  contents <- paste0(paste(readLines(profile, warn = FALSE), collapse = "\n"), "\n")
  if (identical(contents, legacy_profile)) {
    backup <- paste0(profile, ".pre-vscode-r-3-", format(Sys.time(), "%Y%m%d%H%M%S"))
    if (file.exists(backup) || !file.rename(profile, backup)) {
      stop("Could not back up the legacy user .Rprofile")
    }
    message("Legacy user .Rprofile backed up to ", backup)
  } else {
    message("Custom user .Rprofile preserved; check it for legacy graphics/session hooks")
  }
}
