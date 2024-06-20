# Use the official TensorFlow image as a parent image
FROM tensorflow/tensorflow:2.14.0-gpu-jupyter

# Set the working directory in the container
WORKDIR /workspace

# Copy the current directory contents into the container at /workspace
COPY . /workspace

# Install any additional dependencies specified in requirements.txt
RUN pip install --upgrade pip \
    && if [ -f "requirements.txt" ]; then pip install -r requirements.txt; fi

# Install any additional system dependencies
RUN apt-get update && apt-get install -y \
    nano \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set environment variable to avoid bytecode creation
ENV PYTHONDONTWRITEBYTECODE 1

# Set environment variable to buffer stdout and stderr
ENV PYTHONUNBUFFERED 1

# Expose Jupyter Notebook port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''"]
