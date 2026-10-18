# Python formatting and environment recovery

The devcontainer pins Python to **3.14.7** using the official Python feature v1.
Update this version deliberately after checking Python tooling compatibility.

A rebuild with Python set to latest installed 3.15.0. The autopep8 extension
2026.4.0 bundled typing_extensions 4.12.2, which accessed the removed
typing.no_type_check_decorator attribute and crashed before formatting.
Pinning the runtime avoids that incompatibility and preserves the interpreter
path used by existing Python 3.14.7 virtual environments.

autopep8.interpreter explicitly uses /usr/local/python/current/bin/python.
This keeps the formatter server independent of a selected course virtual
environment that may contain a broken interpreter link. The Python feature
provides the autopep8 extension and default Python formatter setting.

## Apply the configuration

Save your work and commit changes. In Codespaces, run **Codespaces: Rebuild
Container**; locally, run **Dev Containers: Rebuild Container**. A configuration
commit alone does not replace the Python interpreter in a running container.
After rebuilding, check:

```sh
python --version
python -m autopep8 --version
```

Python should report 3.14.7. Open a disposable Python file containing x=  1,
run Format Document, and check that it becomes x = 1. Check the autopep8 Output
channel if the server fails to initialize.

## Existing virtual environments

A virtual environment can survive a rebuild while its interpreter path no
longer exists. Inspect its pyvenv.cfg and bin/python symlink, then invoke its
bin/python --version. Restoring the exact Python 3.14.7 installation may restore
an environment that points to /usr/local/python/3.14.7/bin/python.
Verify its imports before using it for coursework.

Preserve the old environment. If it remains unusable, create a separate new
environment from the course dependency specification and select that interpreter.
Do not overwrite or delete the old environment or copy installed packages blindly.

The emergency replacement of a bundled extension dependency in the live
Python 3.15 container is temporary and is not shipped in this repository.
Extension updates may replace it. Rebuild with the pinned runtime for the
repository-managed fix; review the runtime pin when updating Python tooling.
