# replace locale
cookbook_file "/etc/default/locale" do
  source "locale"
end
