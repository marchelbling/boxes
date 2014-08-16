define :vim_bundle_install, :bundle_repo => nil,
                            :bundle_dir => '/var/lib/vim/addons/bundle',
                            :user => 'root',
                            :group => 'root' do
  bundle = params[:bundle_repo]
  bundle_dir = params[:bundle_dir]
  user = params[:user]
  group = params[:group]

  if !File.directory? bundle_dir
    directory bundle_dir do
      owner user
      group group
      mode '0777'
      action :create
      recursive true
    end
  end

  bash "install bundle #{bundle}" do
    user user
    cwd bundle_dir
    code <<-EOH
      bundle="#{bundle}"
      bundle_name="$( basename "${bundle}" )"
      bundle_name="${bundle_name%.*}"
      if [ ! -d "${bundle_name}" ]
      then
        git clone "${bundle}" "${bundle_name}"
      fi
      cd "${bundle_name}"
      git pull --rebase
      git submodule update --init --recursive
      cd -
    EOH
  end
end
