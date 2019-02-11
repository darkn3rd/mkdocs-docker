# encoding: utf-8

control 'mkdocs-01' do
  impact 1.0
  title 'mkdocs serve should be listening'
  desc 'mkdocs serve be listening.'
  describe port(8000) do
    it { should be_listening }
  end
end

control 'mkdocs-02' do
  impact 1.0
  title 'mkdocs packages should exist'
  desc 'mkdocs packages should exit'

  describe pip('mkdocs') do
    it { should be_installed }
    its('version') { should eq '1.0.4' }
  end

  describe pip('mkdocs-material') do
    it { should be_installed }
    its('version') { should eq '3.3.0' }

  end
end

control 'mkdocs-03' do
  impact 1.0
  title 'mkdoc-docker commands should exist'
  desc 'mkdoc-docker commands should exist'

  describe command('mkdocs') do
    it { should exist }
  end

  describe command('serve') do
    it { should exist }
  end

  describe command('produce') do
    it { should exist }
  end
end
