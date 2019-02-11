# MKDocs Docker Dev Environment

This is a small experimental environment that for experimentation and developer support for MKDocs using Docker.

  Joaquin Menchaca, 2019年1月31日

# Building 

You'll need to edit the Makefile to point to your own namespace.

```bash
make build
make push
```

# Using

From your locoal documentation directory, you can run this image with the following

```bash
cd path/to/your/doc/project
docker run -d -v $PWD:/opt/docs -p 8000:8000 darknerd/mkdocs:latest serve
```

To build and ouput a site:

```bash
cd path/to/your/doc/project
docker run -v $PWD:/opt/docs darknerd/mkdocs:latest produce > ~/Downloads/output.tgz
```