## Starting the Docker development environment

Requires Docker Desktop. From the project's main folder:

```bash
docker build -t egt309-dev .
docker run -p 8888:8888 -v "${PWD}:/app" egt309-dev
```

Open the `http://127.0.0.1:8888/lab?token=...` link printed in the terminal, then open `eda.ipynb`.
Autocomplete is switched on by default (JupyterLab autocompletion + jupyterlab-lsp).