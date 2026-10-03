# R packages are installed in the image by the Rocker r-packages feature.
# sess is taken from the official stable vscode-R v3.0.1 release.
stopifnot(requireNamespace("jgd", quietly = TRUE),
          requireNamespace("sess", quietly = TRUE),
          packageVersion("sess") >= "3.0.1")
message("jgd ", packageVersion("jgd"), " and sess ", packageVersion("sess"), " available")

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
