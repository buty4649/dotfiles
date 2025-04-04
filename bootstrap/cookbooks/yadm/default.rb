dotfiles_repo = "https://github.com/buty4649/dotfiles.git"

package "yadm"

execute "yadm clone && bootstrap" do
  yadm_repo_dir = File.join(ENV["HOME"], ".local", "share", "yadm", "repo.git")
  command <<~COMMAND
    set -e
    yadm clone #{dotfiles_repo}

    # 一旦強制的に反映
    yadm reset --hard

    # スパースを設定
    yadm gitconfig core.sparsecheckout true
    yadm sparse-checkout reapply

    # スパース部分を強制反映
    yadm reset --hard
  COMMAND
  only_if "test ! -d #{yadm_repo_dir}"
end
