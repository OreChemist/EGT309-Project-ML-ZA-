# Start from an official small Python image, like moving into a room that already has Python installed
FROM python:3.11-slim

# Make /app the working folder inside the container
WORKDIR /app

# Copy only the package list first, so Docker can reuse the install step next time (faster rebuilds)
COPY requirements.txt .

# Install every package on the list; --no-cache-dir keeps the image small
RUN pip install --no-cache-dir -r requirements.txt

# Copy our settings file into a temporary spot
COPY overrides.json /tmp/overrides.json

# Put it where JupyterLab looks for default settings, so autocomplete is already switched on
RUN mkdir -p "$(python -c 'import sys; print(sys.prefix)')/share/jupyter/lab/settings" \
 && cp /tmp/overrides.json "$(python -c 'import sys; print(sys.prefix)')/share/jupyter/lab/settings/overrides.json"

# Tell Docker that JupyterLab will use port 8888
EXPOSE 8888

# Start JupyterLab; 0.0.0.0 lets your browser outside the container reach it
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
