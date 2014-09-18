# system-wide powerline
# (see http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin)
['/usr/share/fonts/', '/etc/fonts/conf.d'].each do |font_dir|
  directory font_dir do
    owner 'root'
    group 'root'
    action :create
    recursive true
  end
end

bash "install powerline fonts" do
  cwd  '/tmp/'
  code <<-EOH
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf \
         https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    sudo mv PowerlineSymbols.otf /usr/share/fonts/
    sudo fc-cache -vf
    sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
  EOH
end


vim_global_dir = '/etc/vim'  # see `:echo $VIM`
bundle_dir = vim_global_dir + '/bundle'  # see `:set runtimepath`
pathogen_dir = vim_global_dir + '/autoload'  # see `:set runtimepath`

vimrc_global = vim_global_dir + '/vimrc'
pathogen = pathogen_dir + '/pathogen.vim'

# vimrc & plugins
if !File.directory? vim_global_dir
  directory vim_global_dir do
    owner 'root'
    group 'root'
    mode '0777'
    action :create
    recursive true
  end
end

cookbook_file vimrc_global do
  source 'vimrc'
end

if !File.directory? pathogen_dir
  directory pathogen_dir do
    owner 'root'
    group 'root'
    mode '0777'
    action :create
    recursive true
  end
end

if !File.file? pathogen
  bash 'setup pathogen'  do
    code "curl -LSso #{pathogen} https://tpo.pe/pathogen.vim"
  end
end

['https://github.com/scrooloose/nerdcommenter.git',
 'https://github.com/tpope/vim-fugitive.git',
 'https://github.com/imsizon/wombat.vim.git',
 'https://github.com/xuhdev/SingleCompile.git',
 'https://github.com/bling/vim-airline',
 'https://github.com/kien/ctrlp.vim',
 'https://github.com/scrooloose/syntastic.git',
 'https://github.com/scrooloose/nerdtree.git'].each do |bundle|
  vim_bundle_install do
    bundle_repo bundle
    bundle_dir bundle_dir
  end
end
