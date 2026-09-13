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

Configuration lives in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json). Run `R` or `python` in a terminal, or open a Python notebook and select its Python kernel.

Versions intentionally track latest releases. Rebuilds may install newer versions; record or pin versions later if a course requires reproducibility.

## Keeping your environment up to date

Repositories created from a template are independent copies. Later template changes do **not** automatically update existing repositories.

To adopt an update, compare the shared `.devcontainer/devcontainer.json` with your copy, bring across the changes you want, and commit them in your own repository. Review `.gitignore` updates separately so you retain any personal rules. Then run **Codespaces: Rebuild Container** in a Codespace, or **Dev Containers: Rebuild Container** locally. Save your work first.

## Extending the template over the degree

Add shared tools, libraries, and extensions to the dev-container configuration as courses need them. Document new dependencies and setup steps here, and test a fresh container after making changes. Keep assignments, solutions, datasets, credentials, and personal notes in individual coursework repositories.

This is a configuration template, not a published prebuilt container image. The repository provides the instructions Codespaces uses to build each student's environment.
