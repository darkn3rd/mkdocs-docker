# **MKDocs Docker Dev Environment**

This is a small experimental environment that for experimentation and developer support for [MKDocs](https://www.mkdocs.org/) using Docker.

  Joaquin Menchaca, 2019年1月31日

## **Building**

The current `Makefile` points to my personal namespace.  To push releases into your own account, you will need to use your own namespace by modifying the `NS` variable.

```bash
make build
make push
```

## **Using**

From your local documentation directory, you can run this image with the following

```bash
pushd path/to/your/doc/project
docker run -d -v $PWD:/opt/docs -p 8000:8000 darknerd/mkdocs:latest serve
popd
```

To build and ouput a site:

```bash
pushd path/to/your/doc/project
docker run -v $PWD:/opt/docs darknerd/mkdocs:latest produce > ~/Downloads/output.tgz
popd
```

## **Testing**

The testing uses a system integration and compliance testing cool [InSpec](https://www.inspec.io/). With Inspec installed, you can run these:

```bash
make test  # test mockup docs with Inspec
make stop  # stop related running containers
```

## **Extra Stuff**

### **Local Vagrant Development Environment**

A local virtual development environment using [Vagrant](https://www.vagrantup.com/) is availble for use that contains [Docker](https://www.docker.com/), [Python](https://www.python.org/), and [Ruby](https://www.ruby-lang.org/) environments.  It includes both [MKDocs](https://www.mkdocs.org/) and [InSpec](https://www.inspec.io/) tools.

```bash
# Create virutal guest and provision
vagrant up
# Log Into System
vagrant ssh 
# Run Some Commands
cd /vagrant # $CWD mounted as /vagrant
make build
make test
make stop
make clean
```

### **CI Pipeline with Jenkins**

A `Jenkinsfile` is provided to use with Jenkins 2.0.  A test Jenkins environment is provided.  If you have Docker Compose installed, you can test this with:

```bash
# Start Jenkins environment
docker-compose up -d
# Search logs for master administrator password
docker-compose logs
# Navigate to localhost:8080
```

After this, access Jenkins with `localhost:8080`, and then manually import the project's Jenkinsfile to create a pipeline.