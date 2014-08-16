include_recipe 'apt'

package('screen')
cookbook_file "/etc/screenrc" do
  source "screenrc"
  mode "0644"
end

package('vim')

# network/package tools
package('apt')
package('apt-transport-https')
package('curl')
package('libcurl4-gnutls-dev')
package('wget')
package('ethtool')

# compression tools
package('zip')
package('unzip')
package('pigz')
package('pbzip2')
package('p7zip-full')
#package('p7zip-rar')

# system
package('iotop')
package('htop')
package('localepurge')
package('cron-apt')
package('tmpreaper') # cleanup files based on their age

# build tools
package('build-essential') # gcc & make
package('automake')
package('ccache')
package('cmake')
package('libboost-dev')
package('libxml2-dev')
package('libssl-dev')
package('libwww-perl')

# misc
package('fontconfig')
package('tree')
package('gdb')
package('python-dev')
