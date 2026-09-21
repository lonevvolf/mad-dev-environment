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
- Lightweight Linux desktop with X11 and a noVNC browser display on port 6080

Configuration lives in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json). Run `R` or `python` in a terminal, or open a Python notebook and select its Python kernel.

Versions intentionally track latest releases. Rebuilds may install newer versions; record or pin versions later if a course requires reproducibility.

## R plots: browser viewer and interactive desktop

### Normal plots with httpgd

Start a fresh R terminal (**Ctrl+Shift+P → R: Create R terminal**) and run:

```r
plot(1:10, main = "Normal plotting test")
dev.cur()
```

The httpgd browser viewer should open automatically. The device may be named `unigd`; this is expected for httpgd. The included [`.Rprofile`](.Rprofile) opens the viewer when the plotting device is created. You do not need to open the desktop for normal plots.

### Open the desktop for X11 input

The standard [desktop-lite feature](https://github.com/devcontainers/features/tree/main/src/desktop-lite) provides a Linux desktop for interactive graphics.

1. After the container finishes building, open VS Code's **Ports** tab.
2. Find forwarded port **6080** and choose **Open in Browser** (the globe icon). If it is missing, choose **Forward a Port** and enter `6080`. Keep the Codespaces port visibility **Private**.
3. In the noVNC page, click **Connect** and enter the default desktop password: `vscode`.
4. Keep this desktop open while running the R commands below.

The R graphics window appears **inside this browser desktop**, not on your local Windows desktop or in the httpgd viewer.

### Select points with identify()

Open `X11()` **before** drawing the plot so both the plot and mouse input use the same device:

```r
X11()
plot(cars$speed, cars$dist, xlab = "Speed", ylab = "Stopping distance")
ind <- with(cars, identify(speed, dist))
cars[ind, ]
```

- **Left-click near a point** to select it. Its row number appears beside it.
- **Right-click inside the plot area to finish.** A middle click (pressing the mouse wheel) also finishes.
- **No Finish menu appears on X11.** Selection ends directly and the R terminal returns to its `>` prompt. Then run `cars[ind, ]` to inspect the selected rows.
- To finish automatically after one selection, use `identify(speed, dist, n = 1)` inside the `with(cars, ...)` call.

Do not draw the plot first and then call `X11(); plot.new()`: that creates a blank X11 plot while leaving your data plot on the earlier device.

For coordinates rather than row numbers, run `locator()` on an existing X11 plot. Left-click the desired positions, then right-click or middle-click to finish.

### Return to normal plots

While the X11 device is current, new plots continue to appear there. After finishing input, close that device:

```r
dev.off()
plot(1:10)
```

If you have several devices open and want to close all plot windows and histories, run `graphics.off()` before the next plot. The configured default device then opens the httpgd browser viewer. A fresh R terminal is another way to check normal plotting.

### Troubleshooting

If no R window appears in the desktop, check:

```r
Sys.getenv("DISPLAY")  # Expected: ":1"
capabilities("X11")    # Expected: TRUE with the desktop running
```

After adding desktop-lite to an existing workspace, rebuild the container and start a fresh R terminal. Opening port 6080 alone does not install or start the desktop feature.

Both interactive X11 point selection (including finishing input) and normal httpgd browser plotting were confirmed in an existing Codespace on 21 September 2026. The normal device reported `unigd`.

## Keeping your environment up to date

Repositories created from a template are independent copies. Later template changes do **not** automatically update existing repositories.

To adopt an update, compare the shared `.devcontainer/devcontainer.json` and `.Rprofile` with your copies, bring across the changes you want, and commit them in your own repository. Review `.gitignore` updates separately so you retain any personal rules. Then run **Codespaces: Rebuild Container** in a Codespace, or **Dev Containers: Rebuild Container** locally. Save your work first.

## Extending the template over the degree

Add shared tools, libraries, and extensions to the dev-container configuration as courses need them. Document new dependencies and setup steps here, and test a fresh container after making changes. Keep assignments, solutions, datasets, credentials, and personal notes in individual coursework repositories.

This is a configuration template, not a published prebuilt container image. The repository provides the instructions Codespaces uses to build each student's environment.
