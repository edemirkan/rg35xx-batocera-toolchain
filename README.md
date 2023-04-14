# RG35XX Batocera CFW Toolchain Docker image

Based on the [RG35XX Batocera CFW](https://github.com/rg35xx-cfw) by acmeplus.

## Installation

With Docker installed and running, `make shell` builds the toolchain and drops into a shell inside the container. The container's `~/workspace` is bound to `./workspace` by default. The toolchain is located at `/opt/` inside the container.

After building the first time, unless a dependency of the image has changed, `make shell` will skip building and drop into the shell. Running `make shell` from another window while already in a running shell will attach to the already running image.

## Workflow

- On your host machine, clone repositories into `./workspace` and make changes as usual.
- In the container shell, find the repository in `~/workspace` and build as usual.

See [setup-env.sh](./build/setup-env.sh) for some useful vars for compiling that are exported automatically.