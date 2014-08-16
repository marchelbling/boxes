include_recipe 'root_ssh_agent::ppid'  # enable ssh forwarding during chef run
include_recipe 'openssh'
include_recipe 'timezone-ii'
include_recipe 'ntp'
include_recipe 'git'
include_recipe 'base::locale'
include_recipe 'base::packages'

include_recipe 'java'
include_recipe 'python'
include_recipe 'python::pip'

include_recipe 'base::ssh_keys'
include_recipe 'base::vim'
include_recipe 'base::git'


cookbook_file '/etc/ssh/sshd_config' do
  source 'sshd_config'
end
