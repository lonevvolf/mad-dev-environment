FROM mcr.microsoft.com/devcontainers/base:ubuntu

# R packages such as car need Fortran, BLAS/LAPACK and NLopt when built from source.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gfortran \
        libblas-dev \
        liblapack-dev \
        cmake \
        libnlopt-dev \
    && rm -rf /var/lib/apt/lists/*
