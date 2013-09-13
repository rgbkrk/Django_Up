#
# Cookbook Name:: django_up
# Recipe:: default
#
# Copyright (C) 2013 Kyle Kelley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "python::source"

version = node['python']['version']
install_path = "#{node['python']['prefix_dir']}/bin/python#{version.split(/(^\d+\.\d+)/)[1]}"

Chef::Log.info("INFO: #{install_path}")
Chef::Log.info("INFO: #{node['python']['binary']}")

link node['python']['binary'] do
  to install_path
  not_if { ::File.exists?(install_path) }
end

include_recipe "python::pip"
include_recipe "python::virtualenv"

python_pip "gunicorn"
python_pip "django"

