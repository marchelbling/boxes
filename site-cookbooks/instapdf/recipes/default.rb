include_recipe 'nodejs'
include_recipe 'nodejs::npm'
include_recipe 'hostname'

include_recipe 'instapdf::packages'
include_recipe 'instapdf::builds'
