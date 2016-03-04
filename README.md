# fusion-doc-builder
Docker container for building Lucidworks docs

NOTE: This is a public repo.

1. Verify that your home directory contains a `.ssh` directory containing ` id_dsa` and `id_rsa` files.  If not, generate them with `ssh-keygen`.
1. Download and install the Docker Toolbox: https://www.docker.com/products/docker-toolbox
1. Launch the Kitematic app, one of the tools in the Docker Toolbox.
1. In the search field, enter fusion-doc-builder.
1. In the search results, click **Create** on fusion-doc-builder. (Be sure to click the one from Lucidworks!  There's another repo by the same name from a different organization.)
1. Once the fusion-doc-builder container is running, find the access URL for its `22/tcp` Docker port, usually `192.168.99.100:32769`.
1. Launch the Docker CLI.
1. Run `ssh-add`.
1. Log in to the container as the "jenkins" user: `ssh -p 32769 jenkins@192.168.99.100`.  The password is also "jenkins".
1. Clone the Fusion-docs repo (it's a private repo): `git clone https://github.com/lucidworks/Fusion-docs`.
1. Build the docs site: `./build-versions.sh <versions>`.
1. Serve up the site: `jekyll serve --host 0.0.0.0 --port 8764 --skip-initial-build --no-watch`.
1. In Kitematic, find the access URL for the container's `8764/tcp` port, usually `192.168.99.100:32768`.
1. Access the docs site: `http://192.168.99.100:32768/`.
