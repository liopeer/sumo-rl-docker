![Push to Docker Hub](https://github.com/liopeer/sumo-rl-docker/actions/workflows/build_push_dockerhub.yml/badge.svg)
# sumo-rl-docker
 - [Sumo](https://eclipse.dev/sumo/), [sumo-rl](https://eclipse.dev/sumo/) with RLlib and StableBaselines3 in a dockerized format for development and cluster deployment
 - the backend is provided by PyTorch
 - Docker Hub Repo -> [https://hub.docker.com/r/lionelpeer/sumo-rl](https://hub.docker.com/r/lionelpeer/sumo-rl)

## Requirements
Host machine with installed:
1. Running installation of Docker [Docker Desktop](https://docs.docker.com/desktop/)
2. Nvidia Container Toolkit if Nvidia GPUs are available on the host [Nvidia Container Toolki](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
    - Ubuntu instructions are outdated as of (March 2024), modify them according to:
        1. Configure the production repository as indicated in step 1
        2. Comment all lines in `/etc/apt/sources.list.d/nvidia-container-toolkit.list` and add the following line instead: `deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/ubuntu18.04/$(ARCH) /`
        3. Follow the rest of the instructions.
    - Problem is described in [Issue 89](https://github.com/NVIDIA/nvidia-container-toolkit/issues/89)
3. [Rosetta2](https://support.apple.com/en-in/102527) if you are working on ARM/M1 macOS, most likely you have it already
Compatibility of the image was tested with:
1. macOS with ARM (M1) architecture
2. Linux on x86/x64

## Pulling the Image
 - `docker pull lionelpeer/sumo-rl:latest`

## Starting an interactive Container
 - `-it` flag starts an interactive session
 - `--rm` flag cleans up, after you exit the container and I recommend using it
 - `-v $(pwd):/usr/src/` if you want your current (host) directory to be accessible in the container's `/usr/src/` (you can of course also use a different mounting point)

macOS (ARM/M1)
 - `docker run -it --rm -v $(pwd):/usr/src/ --platform=linux/amd64 lionelpeer/sumo-rl`

Linux (x86/x64) without GPUs
 - `docker run -it --rm -v $(pwd):/usr/src/ lionelpeer/sumo-rl`

Linux (x86/x64), giving access to GPUs 2 and 3, e.g. when having 4 GPUs (0,1,2,3)
 - `docker run -it --rm -v $(pwd):/usr/src/ --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES="2,3" lionelpeer/sumo-rl`

**In all cases:**
`RLlib` struggles with the container size, so if you want to use `RLlib`, set the additional flag
 - `--shm-size=10.24gb`

## Using a Jupyter server in the Container
Run an interactive session like above, but add the following flag:
 - `-p 8888:8888`

 In the container shell run:
 - `jupyter lab --no-browser --ip=0.0.0.0 --allow-root`

open a browser and go to `localhost:8888/<ACCESS_TOKEN>`. the access token will be exposed in the shell.

## Using GUIs
 - should work with some X11 forwarding when using a Linux host
 - really difficult when working with Mac host. Starting point -> [https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949](https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949)
 
please open a PR if you have instructions on these topics

## Contributing
Please open issues and pull requests, helps make it more stable.