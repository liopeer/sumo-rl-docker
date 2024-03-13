# sumo-rl-docker
 - [Sumo](https://eclipse.dev/sumo/), [sumo-rl](https://eclipse.dev/sumo/) with RLlib and StableBaselines3 in a dockerized format for development and cluster deployment
 - the backend is provided by PyTorch
 - Docker Hub Repo -> [https://hub.docker.com/r/lionelpeer/sumo-rl](https://hub.docker.com/r/lionelpeer/sumo-rl)

## Requirements
Host machine with installed:
1. Running installation of Docker [Docker Desktop](https://docs.docker.com/desktop/)
2. Nvidia Container Toolkit if Nvidia GPUs are available on the host [Nvidia Container Toolki](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
3. [Rosetta2](https://support.apple.com/en-in/102527) if you are working on ARM/M1 macOS, most likely you have it already
Compatibility of the image was tested with:
1. macOS with ARM (M1) architecture
2. Linux on x86/x64

## Pulling the Image
 - `docker pull lionelpeer/sumo-rl:latest`

## Starting an interactive Container
macOS (ARM/M1)
 - `docker run -it --platform=linux/amd64 lionelpeer/sumo-rl:latest`
Linux (x86/x64) without GPUs
 - `docker run -it lionelpeer/sumo-rl:latest`
Linux (x86/x64), giving access to GPUs 2 and 3, e.g. when having 4 GPUs (0,1,2,3)
 - `docker run -it --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES="2,3" lionelpeer/sumo-rl:latest`
**In all cases:**
`RLlib` struggles with the container size, so in all above cases it might be helpful to use the following flag
 - `--shm-size=10.24gb`

## Using a Jupyter server in the Container
add the following flags to above commands
 - `-p 8888:8888`
 - `--entrypoint="jupyter lab --no-browser --ip=0.0.0.0"`
open a browser and go to `localhost:8888`

## Using GUIs
 - should work with some X11 forwarding when using a Linux host
 - really difficult when working with Mac host. Starting point -> [https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949](https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949)
please open a PR if you have instructions on these topics

## Contributing
Please open issues and pull requests, helps make it more stable.