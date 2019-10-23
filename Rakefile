require File.expand_path('../support/dotfile', __FILE__)
require 'fileutils'

SYMLINKS = %w[
  zshrc
  zshenv
  tmux.conf
  agignore
  git_template
  gitconfig
  gitignore
]

SYMLINKS.each do |file|
  desc "Symlink #{file} into home"
  task file do
    Dotfile.new(file).install_symlink
  end
end

desc "Create the .config directory"
task :config_dir do
  FileUtils.mkdir_p(File.expand_path("~/.config"))
end

desc "Symlink the Scripts directory"
task :scripts do
  scripts = Dotfile.new("Scripts")
  scripts.home_path = Pathname.new("~/Scripts")
  scripts.install_symlink
end

desc "Install stuff from brew"
task :homebrew do
  system('brew install postgresql rbenv ruby-build git hub zsh zsh-syntax-highlighting tmux neovim/neovim/neovim the_silver_searcher ctags carthage ffmpeg keybase nmap node yarn')
end

desc "Install vim config"
task :vim_config => :config_dir do
  nvim = Dotfile.new("nvim")
  nvim.home_path = Pathname.new("~/.config/nvim")
  nvim.install_symlink
  vimrc = Dotfile.new("vimrc", "~/.config/nvim/init.vim")
  vimrc.install_symlink
  vim = Dotfile.new("vim", "~/.config/nvim")
  vim.install_symlink
end

desc "Install vim-plug"
task :vim_plug do
  unless File.exist?('nvim/autoload/plug.vim')
    unless system('curl -fLo nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
      STDERR.puts "Could not fetch vim-plug. Continuing..."
    end
  end
end

desc "Install vim plugins"
task :vim_plugins => :vim_plug do
  unless system('nvim -c ":PlugInstall" -c ":qa"')
    STDERR.puts "Could not automatically install vim bundles. Continuing..."
  end
end

desc "Install all files"
task :install => (SYMLINKS + %w[gitconfig gitignore scripts homebrew vim_config vim_plugins]) do
  if ENV['SHELL'] !~ /zsh/
    STDERR.puts "Warning: You seem to be using a shell different from zsh (#{ENV['SHELL']})"
    STDERR.puts "Fix this by running:"
    STDERR.puts "  chsh -s `which zsh`"
  end
end

task default: :install
