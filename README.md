# FH Technikum Wien — MAD Development Environment

A shared R and Python development environment for students of the **Artificial Intelligence & Data Science (MAD) Master's degree at FH Technikum Wien** (University of Applied Sciences Technikum Wien). Use this GitHub template with GitHub Codespaces or VS Code Dev Containers throughout the degree.

Maintained by a student for classmates; this is an unofficial community resource. This template contains environment configuration only; keep your coursework in your own repository.

## Start your own workspace

1. Click **Use this template → Create a new repository** on this repository.
2. Choose a name for your coursework repository and select **Private** if you want to keep your work private.
3. In your new repository, click **Code → Codespaces → Create codespace on main**.
4. Wait for the container build and package installation to finish. The first launch may take several minutes.
5. Add your course folders and work in your own repository. Commit and push changes there.

You do not need Docker installed locally for Codespaces. Reopen an existing workspace from [your Codespaces](https://github.com/codespaces) instead of creating a new one each time.

For local use, clone your own repository, install Docker and the VS Code Dev Containers extension, and run **Dev Containers: Reopen in Container**.

## Included environment

- Ubuntu base: `mcr.microsoft.com/devcontainers/base:ubuntu`
- R through the latest Rocker `r-apt` feature, with `languageserver` support
- Latest Python through the official Python feature
- Latest pip, numpy, pandas, scipy, matplotlib, scikit-learn, jupyterlab, and ipykernel
- VS Code extensions for R, Python, Pylance, and Jupyter
- Stable vscode-R 3.x with its bundled `sess` session bridge and CRAN `jgd` graphics

Configuration lives in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json). Run `R` or `python` in a terminal, or open a Python notebook and select its Python kernel.

Versions intentionally track latest releases. Rebuilds may install newer versions; record or pin versions later if a course requires reproducibility.

## R sessions and plots in VS Code

Use the stable **REditorSupport.r** extension (3.0.1 or later stable 3.x).
The image build installs stable `jgd` from [CRAN](https://cran.r-project.org/package=jgd)
and `sess` 3.0.1 with its dependencies from the
[official vscode-R v3.0.1 release](https://github.com/REditorSupport/vscode-R/tree/v3.0.1/sess).
Rocker's `r-packages` feature runs after R is installed, so these packages are
included in the built image rather than installed when a terminal first opens.
[`.devcontainer/setup-r.R`](.devcontainer/setup-r.R) checks availability and
migrates the old home profile.
Rocker's full R support retains `languageserver` and `httpgd`; if needed,
select `r.plot.backend: "auto"` to prefer jgd with httpgd as a supported fallback.

The configured settings are `r.sessionWatcher: true` and `r.plot.backend: "jgd"`.
Fresh workspaces already have `sess` installed. Start **R: Create R terminal**.
A newer extension may offer to update `sess` when its bundled version changes;
keep the pinned stable source in the image configuration in step with extension upgrades.

Run in that managed terminal:

```r
plot(1:10)
dev.cur()
packageVersion("sess")
packageVersion("jgd")
```

The session should attach and the plot should appear in VS Code's plot viewer.
Use its arrows for plot history. No external-browser device hook, X11 desktop,
desktop-lite feature, or port 6080 is needed.

### Updating an existing Codespace

Save your work, pull the configuration update, and run **Codespaces: Rebuild Container**.
Start a fresh managed R terminal afterwards. Check the remote R extension's version
and update it through the Extensions view if it is still 2.x or a prerelease.

The old project `.Rprofile` is removed. During setup, an unchanged legacy home
`~/.Rprofile` is moved to a dated `~/.Rprofile.pre-vscode-r-3-*` backup.
Custom home profiles are preserved; remove any old `httpgd::hgd_browse()` device
override or manual vscode-R 2.x session-watcher bootstrap from those yourself.
Review workspace/user settings for old `r.plot.useHttpgd` or session-watcher hacks.

See the [official vscode-R guidance](https://github.com/REditorSupport/vscode-R)
and [jgd installation instructions](https://github.com/REditorSupport/jgd).

## Keeping your environment up to date

Repositories created from a template are independent copies. Later template changes do **not** automatically update existing repositories.

To adopt an update, compare the shared `.devcontainer/devcontainer.json` and `.devcontainer/setup-r.R` with your copies, bring across the changes you want, and commit them in your own repository. Review `.gitignore` updates separately so you retain any personal rules. Then run **Codespaces: Rebuild Container** in a Codespace, or **Dev Containers: Rebuild Container** locally. Save your work first.

## Extending the template over the degree

Add shared tools, libraries, and extensions to the dev-container configuration as courses need them. Document new dependencies and setup steps here, and test a fresh container after making changes. Keep assignments, solutions, datasets, credentials, and personal notes in individual coursework repositories.

This is a configuration template, not a published prebuilt container image. The repository provides the instructions Codespaces uses to build each student's environment.

## Docker inside the development container

The official [Docker-in-Docker feature](https://github.com/devcontainers/features/tree/main/src/docker-in-docker)
installs the Docker CLI, an independent Docker/Moby daemon, Buildx, Compose,
and the VS Code Container Tools extension. This supports building and running
containers from a Codespace terminal, including bind mounts using workspace paths.
The feature manages privileged mode, daemon startup, and dedicated Docker/containerd
storage volumes; no host Docker socket or manual daemon startup is required.

For an existing Codespace, save your work, pull these changes, and run
**Codespaces: Rebuild Container**. Locally, run **Dev Containers: Rebuild Container**.
The Docker feature is installed during the image build, so pulling alone is insufficient.
After rebuilding, run this from the repository root as your normal development user:

```bash
bash .devcontainer/test-docker.sh
```

The smoke test checks `docker version`, `docker info`, Compose, and Buildx, then
builds and runs a small Alpine container and checks its output. It removes its
test image on exit; the pulled Alpine base image remains cached. Internet access
to pull the base image is required. This test must be run inside the rebuilt
devcontainer; host Docker results do not validate Codespaces.

Docker images and volumes are separate from coursework files. Treat them as
rebuildable data, especially when deleting or recreating a Codespace.
