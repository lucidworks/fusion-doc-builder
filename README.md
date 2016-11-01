# fusion-doc-builder

Docker container for building Lucidworks Fusion docs.

NOTE: This is a public repo.

## Docker for Mac / Docker for Windows

Download and install the appropriate flavor of the Docker tools for your machine:

* [Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Docker for Windows](https://download.docker.com/win/stable/InstallDocker.msi)

Details on this toolset are found in this [Docker blogpost](https://blog.docker.com/2016/07/docker-for-mac-and-windows-production-ready/)


## Set up  .ssh id files for GitHub

This docker container will be used to build the Fusion documentation from the Lucidworks github repo `Lucidworks/Fusion-docs`.
Github provides two ways to clone a directory:  Clone with SSH or Clone with HTTPS.
If you clone with HTTPS, git will prompt you for you github login and password.
Cloning with SSH uses the SSH authentication agent, name `ssh-agent`.
It requires that your home directory contains a `.ssh` directory with `id_rsa` file.
To create an `id_rsa` file, run the command: `ssh-keygen -t rsa -b 4096`.
Make sure that your Github account settings include this public key.
To add to your Github settings, go to https://github.com/settings/ssh, click the "New SSH Key" button in the top-right, and paste your rsa_id.pub into the "Key" area.
Finally, you must make these available to the SSH authentication agent via command:  `ssh-add`.

## Run Docker/Kitematic

### Mac

On the MacOS, when the Docker app is running, the docker whale icon will be present in the top toolbar.  If it isn't running, launch the Docker app from the Applications folder.
Clicking on this icon opens the drop-down menu, choose "Open Kitematic"

> Note: if Kitematic is not already installed, the Docker app will provide a download link. Use this to download the .zip file which contains the app. The Mac OS security won't allow this app run and it will fail with message that the download is corrupt. There is a workaround described [here](https://forums.docker.com/t/kitematic-mac-download-corrupt/9256/8)

### Windows

Launch Docker, launch Kitematic.

## Create fusion-doc-builder, login to container to build the Fusion docs

1. In the search field, enter fusion-doc-builder.
1. In the search results, click **Create** on fusion-doc-builder.
1. Once the fusion-doc-builder container is running, Kitematic displays the access URLs for all open ports. Find the access URL for port 22, the port reserved for ssh access.  e.g., Docker port `22/tcp`, access URL `localhost:32769`.
1. Launch the Docker CLI.
1. Run `ssh-add`.
1. Log in to the container as the "jenkins" user, using the access URL port and IP address for port 22: `ssh -p <port> jenkins@<IP-address>`. The user "jenkins" has password "jenkins".
1. Clone the Fusion-docs repo (it's a private repo, hence the need for Github SSH key): `git clone git@github.com:Lucidworks/Fusion-docs.git`.
1. Choose the version of the documentation to build:
2. `cd Fusion-docs`
2. `git checkout <version-to-build>`
1. Run the build script: `./build.sh`.

## Test the build using `jekyll serve`

Jekyll is a Ruby application and uses the following environment variable to locate jekyll and its components: `PATH`, `GEM_HOME`, `GEM_PATHS`
The following command sequence will set up the jekyll server in the docker container and serve the generated site
in directory `Fusion-docs/jekyll/_site`:

```bash
cd jekyll
export PATH=/usr/local/bundle/bin:$PATH
export GEM_HOME=/usr/local/bundle
export GEM_PATHS=/usr/local/bundle:/usr/local/lib/ruby/gems/2.3.0
jekyll serve --host 0.0.0.0  --skip-initial-build --no-watch
```
The Jekyll server runs on port 4000 by default.  In Kitematic, find the access URL for the container's `4000/tcp` port.
For example if Kitematic lists  `localhost:32771` as the access URL,
to browse the documentation the browser request URL would be: `http://<container port access url 32771/index.html`.
