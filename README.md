# gh cli docker
This provides GitHub CLI in Docker using a small alpine base image. 

## build

```shell
git clone https://github.com/Aalmann/gh-cli-docker.git

docker build gh-cli-docker -t aalmann/gh-cli:latest
```

This will create a build container for GitHub CLI build on Alpine. The installation ist then copied into the final container image.

## usage
Have a look at the gh.* (shell, batch and PowerShell) files. These scripts call docker with the appropriate arguments for mount point (current working directory) and providing the environment variable for GH_TOKEN, which is required to interact with the GitHub API. This token is required for the most commands, so just provide ```GH_TOKEN``` in your environment. 
