directory '/root/.ssh/' do
    owner 'root'
    group 'root'
    mode '0700'
    action :create
end

ssh_keys = []
users = data_bag('users')
users.each do |user_id|
  ssh_keys << data_bag_item('users', user_id)['ssh_key']
end

template '/root/.ssh/authorized_keys' do
  source 'authorized_keys.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables :authorized_keys => ssh_keys
end
