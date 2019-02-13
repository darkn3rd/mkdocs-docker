# NAME: Vagrantfile
# AUTHOR: Joaquin Menchaca
# UPDATED: 2018-10-30
#
# PURPOSE: Single Machine Demo
# DEPENDENCIES:
#  * VirtualBox, Vagrant
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

############### INLINE SCRIPTS
@docker_install = <<SCRIPT
  ##### Add Docker Repo
  DOCKER_REPO="https://download.docker.com/linux/ubuntu"
  curl -fsSL ${DOCKER_REPO}/gpg | apt-key add -
  add-apt-repository \
    "deb [arch=amd64] ${DOCKER_REPO} \
    $(lsb_release -cs) \
    stable"
  apt-get update -qq

  ##### Prerequisites (just in case)
  apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      software-properties-common

  ##### Install Docker
  apt-get install -y docker-ce
  usermod -aG docker 'vagrant'
SCRIPT

@devtools_install = <<SCRIPT
  sudo apt-get update -qq
  sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl
SCRIPT

@pyenv_install = <<SCRIPT
  if [[ ! -d $HOME/.pyenv ]]; then
    curl https://pyenv.run | bash
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
  else
    echo "'$HOME/.pyenv' already exists, skipping"
  fi
SCRIPT

@rbenv_install = <<SCRIPT
  if [[ ! -d $HOME/.rbenv ]]; then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  else
    echo "'$HOME/.rbenv' already exists, skipping"
  fi
SCRIPT

@python_install = <<SCRIPT
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  pyenv install 3.7.2
  pyenv global 3.7.2
  pip install --upgrade pip
SCRIPT

@ruby_install = <<SCRIPT
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv install 2.5.3
  rbenv global 2.5.3
  echo 'gem: --no-document' >> ~/.gemrc
SCRIPT

@mkdocs_install = <<SCRIPT
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  pip install mkdocs
SCRIPT

@dockercompose_install = <<SCRIPT
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  pip install docker-compose
SCRIPT

@inspec_install = <<SCRIPT
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  gem install inspec
SCRIPT
###############

# default virtual provider if VBOX_PROVIDER not set
@provider = ENV['VBOX_PROVIDER'] || RUBY_PLATFORM =~ /mingw32/ ? 'hyperv' : 'virtualbox'

Vagrant.configure('2') do |config|
  config.vm.provider @provider
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.hostname = 'workstation.dev'

  # map port 8080 to localhost (127.0.0.1)
  config.vm.network 'forwarded_port', guest: 8080, host: 8080
  
  # Docker Dev Enivironment
  config.vm.provision :shell, inline: @docker_install, name: 'docker_install'

  # Common Dev Tools for both Python and Ruby
  config.vm.provision :shell, inline: @devtools_install, 
    name: 'devtools_install', privileged: false

  # Python Dev Environment (local)
  config.vm.provision :shell, inline: @pyenv_install, 
    name: 'pyenv_install', privileged: false
  config.vm.provision :shell, inline: @python_install, 
    name: 'python_install', privileged: false
  config.vm.provision :shell, inline: @mkdocs_install, 
    name: 'mkdocs_install', privileged: false

  # Ruby Dev Environemnt (local)
  config.vm.provision :shell, inline: @rbenv_install, 
    name: 'rbenv_install', privileged: false
  config.vm.provision :shell, inline: @ruby_install, 
    name: 'ruby_install', privileged: false
  config.vm.provision :shell, inline: @inspec_install, 
    name: 'inspec_install', privileged: false

  # Docker-Compose Support
  config.vm.provision :shell, inline: @dockercompose_install, 
    name: 'docker-compose_install', privileged: false
end

