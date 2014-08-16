clone_dir='/opt/git/'

directory clone_dir do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
  recursive true
end

###### Poppler
# http://poppler.freedesktop.org/
poppler = clone_dir + 'poppler'
git poppler do
  repository 'git://git.freedesktop.org/git/poppler/poppler'
  revision 'master'
  action :sync
end

bash "build poppler fork" do
  cwd poppler
  code <<-EOH
    ./autogen.sh --enable-xpdf-headers
    make
    sudo make install
    sudo ldconfig
  EOH
end

###### fontforge
fontforge = clone_dir + 'fontforge'
git fontforge do
  repository 'https://github.com/fontforge/fontforge.git'
  revision 'master'
  action :sync
end

bash "build fontforge fork" do
  cwd fontforge
  code <<-EOH
    ./boostrap
    ./configure
    make
    sudo make install
    sudo ldconfig
  EOH
end


###### pdf2htmlEX
# setup pdf2htmlEX
pdf2htmlEX = clone_dir + 'pdf2htmlEX'
git pdf2htmlEX do
  repository "https://github.com/coolwanglu/pdf2htmlEX.git"
  revision "master"
  action :sync
end

bash "build pdf2htmlEX fork" do
  cwd pdf2htmlEX
  code <<-EOH
    mkdir build && cd build
    cmake .. -DENABLE_SVG=ON
    make
    sudo make install
    sudo ldconfig
  EOH
end
