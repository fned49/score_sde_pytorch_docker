# Use the NVIDIA CUDA 11.0 runtime base image
FROM nvidia/cuda:11.0-cudnn8-runtime-ubuntu20.04

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    python3-pip python3-dev wget build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set Python3 as default
RUN ln -s /usr/bin/python3 /usr/bin/python

# Upgrade pip
RUN pip install --upgrade pip

# Copy and install Python requirements
COPY requirements.txt /workspace/requirements.txt
WORKDIR /workspace
RUN pip install -r requirements.txt

# Set environment variables for CUDA
ENV PATH="/usr/local/cuda/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# Default command
CMD ["bash"]

