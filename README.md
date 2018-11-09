# Docker Image Blueprint for Inspectrum

> inspectrum is a tool for analysing captured signals, primarily from software-defined radio receivers - 
[Official project repository](https://github.com/miek/inspectrum)

## Installation

```bash
git clone https://github.com/va1da5/docker-inspectrum.git
cd docker-inspectrum
docker build -t inspectrum .
```

## Usage
You can update the `run.sh` script to change mapped volume. Currently it maps your home directory. To start container run the following.

```bash
./run.sh
```