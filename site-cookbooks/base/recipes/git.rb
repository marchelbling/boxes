# beware that this is a global install so if there are multiple user data_bags
# we'll only use the *first* one to setup gitconfig

git_user = nil
git_email = nil

data_bag('users').first do |user_id|
  user = data_bag_item('users', user_id)
  git_user = user['git_user']
  git_email = user['git_email']
end

template '/etc/gitconfig' do
  source 'gitconfig.erb'
  variables :user => git_user, :email => git_email
end
