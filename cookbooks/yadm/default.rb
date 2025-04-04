dotfiles_repo = "https://github.com/buty4649/dotfiles.git"

package "yadm"

execute "yadm clone && bootstrap" do
  yadm_repo_dir = File.join(ENV["HOME"], ".local", "share", "yadm")
  command "yadm clone #{dotfiles_repo} --bootstrap"
  only_if "test ! -d #{yadm_repo_dir}"
end
