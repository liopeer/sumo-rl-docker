# sumo-rl-docker
 - [Sumo](https://eclipse.dev/sumo/), [sumo-rl](https://eclipse.dev/sumo/) with RLlib and StableBaselines3 in a dockerized format for development and cluster deployment
 - Docker Hub Repo -> [https://hub.docker.com/r/lionelpeer/sumo-rl](https://hub.docker.com/r/lionelpeer/sumo-rl)

## Requirements
Host machine with installed:
1. Running installation of Docker [Docker Desktop](https://docs.docker.com/desktop/)
2. Nvidia Container Toolkit if Nvidia GPUs are available on the host [Nvidia Container Toolki](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
Compatibility of the image was tested with:
1. macOS with ARM (M1) architecture
2. Linux on x86/x64

## Pulling the Image
 - `docker pull lionelpeer/sumo-rl:latest`

## Starting an interactive Container
macOS (ARM/M1)
 - `docker run --platform=linux/amd64 lionelpeer/sumo-rl:latest`
Linux (x86/x64) without GPUs
 - `docker run lionelpeer/sumo-rl:latest`
Linux (x86/x64) with GPUs indexed as (0,1)
 - `docker run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES="0,1" lionelpeer/sumo-rl:latest`
**In all cases:**
`RLlib` struggles with the container size, so in all above cases it might be helpful to use the following flag
 - `--shm-size=10.24gb`