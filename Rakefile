require File.expand_path('../support/dotfile', __FILE__)
require 'fileutils'

SYMLINKS = %w[
  vimrc
  zshrc
  tmux.conf
]

SYMLINKS.each do |file|
  desc "Symlink #{file} into home"
  task file do
    Dotfile.new(file).install_symlink
  end
end

desc "Setup git"
task :gitconfig do
  exec = lambda { |command| system(*command) or STDERR.puts "Command failed: #{command.join(' ')}" }
  config = lambda { |setting, value| exec[['git', 'config', '--global', setting, value]] }

  config["push.default", "tracking"]
  config["color.ui", "true"]

  config["user.name", "Stefan Lindbohm"]
  config["user.email", "stefan@kolizz.com"]
  config["user.signingkey", "55572B41"]
  config["github.user", "kolizz"]

  config["commit.gpgsign", "true"]

  config["mergetool.Kaleidoscope.cmd", %(ksdiff --merge --output "$MERGED" --base "$BASE" -- "$LOCAL" --snapshot "$REMOTE" --snapshot)]
  config["mergetool.Kaleidoscope.trustexitcode", "true"]
  config["difftool.Kaleidoscope.cmd", %(ksdiff --partial-changeset --relative-path "$MERGED" -- "$LOCAL" "$REMOTE")]
  config["merge.tool", "Kaleidoscope"]
  config["diff.tool", "Kaleidoscope"]

  # Aliases
  config["alias.up", %(pull --rebase --prune)]
  config["alias.undo", %(reset HEAD~1)]
  config["alias.wipe", %(!git reset HEAD --hard && git clean -f)]
  config["alias.clog", %(log --pretty=format:'%C(yellow)%h%Creset  %ci %Cred%d%Creset %s (%aN)' --date=local)]
end

desc "Install global gitignore file"
task :gitignore do
  Dotfile.new('gitignore').install_symlink
  unless system('git config --global core.excludesfile "$HOME/.gitignore"')
    STDERR.puts "Could not set git excludesfile"
  end
end

desc "Symlink the Scripts directory"
task :scripts do
  scripts = Dotfile.new("Scripts")
  scripts.home_path = Pathname.new("~/Scripts")
  scripts.install_symlink
end

desc "Install stuff from brew"
task :homebrew do
  system('brew install elasticsearch nginx postgresql rbenv ruby-build git hub zsh zsh-syntax-highlighting')
end

desc "Install all files"
task :install => (SYMLINKS + %w[gitconfig gitignore scripts homebrew]) do
  if ENV['SHELL'] !~ /zsh/
    STDERR.puts "Warning: You seem to be using a shell different from zsh (#{ENV['SHELL']})"
    STDERR.puts "Fix this by running:"
    STDERR.puts "  chsh -s `which zsh`"
  end
end

task default: :install

