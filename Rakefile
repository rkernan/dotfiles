EXCLUDES = [".git", ".gitignore", ".gitmodules", "fonts", "Rakefile", "README.md", "windows.bat"]
ROOT_DIR = File.expand_path(File.dirname(__FILE__))
HOME_DIR = ENV["HOME"]

def get_relative_paths(root_dir, blacklist=[])
  return Dir.entries(root_dir).reject{|entry| entry == "." || entry == ".." || blacklist.include?(entry)}
end

class Symlink

  def initialize(relative_path)
    @source = File.join(ROOT_DIR, relative_path)
    @target = File.join(HOME_DIR, relative_path)
  end

  def to_s
    "#{@source} #{@target}"
  end

  def make
    $stdout.puts("Symlinking: #{@source} => #{@target}")
    FileUtils.symlink(@source, @target)
  end

  def rm
    $stdout.puts("Removing: #{@target}")
    FileUtils.rm_rf(@target)
  end
end

task :install do
  files = get_relative_paths(ROOT_DIR, EXCLUDES)
  files.each do |file|
    Symlink.new(file).make
  end
end

desc "remove all symlinked dotfiles"
task :remove do
  files = get_relative_paths(ROOT_DIR, EXCLUDES)
  files.each do |file|
    Symlink.new(file).rm
  end
end
