# fusion-doc-builder
Docker container for building Lucidworks docs

NOTE: This is a public repo.

## Docker for Mac / Docker for Windows

Download and install the appropriate flavor of the Docker tools for your machine:

* [Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Docker for Windows](https://download.docker.com/win/stable/InstallDocker.msi)

See [this Docker blogpostool](https://blog.docker.com/2016/07/docker-for-mac-and-windows-production-ready/)
for details on this toolset.

## Setting up you .ssh ids

1. Verify that your home directory contains a `.ssh` directory with `id_rsa` file.  If you don't have an `id_rsa` file, generate one with `ssh-keygen -t rsa -b 4096`.  Make sure that your Github account settings include this public key.  To add to your Github settings, go to https://github.com/settings/ssh, click the "New SSH Key" button in the top-right, and paste your rsa_id.pub into the "Key" area.

## Running Docker/Kitematic

1. Launch the Docker app.
1. Start Kitematic app.
> Note for Mac users:  if Kitematic is not already installed, the Docker app will provide a download link. Use this to download the .zip file which contains the app. The Mac OS security won't allow this app run and it will fail with message that the download is corrupt. The workaround [these instructions](https://forums.docker.com/t/kitematic-mac-download-corrupt/9256/8)

## Building fusion-doc-builder image

1. In the search field, enter fusion-doc-builder.
1. In the search results, click **Create** on fusion-doc-builder.
1. Once the fusion-doc-builder container is running, Kitematic displays the access URLs for all open ports. Find the access URL for port 22, the port reserved for ssh access.  e.g., Docker port `22/tcp`, access URL `localhost:32769`.
1. Launch the Docker CLI.
1. Run `ssh-add`.
1. Log in to the container as the "jenkins" user, using the access URL port and IP address for port 22: `ssh -p <port> jenkins@<IP-address>`.  The password is also "jenkins".
1. Clone the Fusion-docs repo (it's a private repo, hence the need for Github SSH key): `git clone git@github.com:Lucidworks/Fusion-docs.git`.
1. Build the docs site: `./build-versions.sh <versions>`.
1. Switch to the jekyll directory: `cd jekyll`.
1. Serve up the site.  From the directory Fusion-docs/jekyll run: `jekyll serve --host 0.0.0.0  --skip-initial-build --no-watch`.  The default port used by the Jekyll server is port 4000.
1. In Kitematic, find the access URL for the container's `4000/tcp` port, e.g. `192.168.99.100:32771/`.
1. Use this access URL to view the Fusion-docs in a browser, e.g.: `http://192.168.99.100:32771/index.html`.
