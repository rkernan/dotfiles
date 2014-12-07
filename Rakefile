require 'highline/import'
require 'pathname'

@verbose_log = (verbose == true) || (Rake.application.options.trace == true)
RakeFileUtils.verbose_flag = false unless @verbose_log

ROOT_DIR = File.expand_path(File.dirname(__FILE__))
HOME_DIR = ENV['HOME']

BASEDIRS = [".", "config", "fonts", "share"]
EXCLUDES = (["Rakefile", "README.md", "windows.bat"] + [BASEDIRS[1, BASEDIRS.size]]).flatten

def log(msg, prefix, stream = $stdout)
  stream.puts("#{prefix} #{msg}")
end

def log_ln(source, target)
  log("Creating symlink: #{source} -> #{target}", "+")
end

def log_rm_ln(source, target)
  log("Removing symlink: #{source} -> #{target}", "-")
end

def log_mkdir(dir)
  log("Creating directory: #{dir}", "+")
end

def ask_yn(msg)
  return agree("#{msg} [yn] ")
end

def ask_rm_rf(target)
  log("#{target} exists. Will not automatically overwrite a non-symlink.", "*", $stderr)
  return ask_yn("  Overwrite?")
end

def log_rm_rf(target)
  log("Removing non-symlink #{target}", "-")
end

def get_relative_paths(root, basedirs, blacklist)
  rel_paths = []
  root_pn = Pathname.new(root)
  basedirs.each do |basedir|
    abs_paths = Dir["#{File.join(root, basedir)}/*"]
    abs_paths.each do |abs_path|
      if !blacklist.include?(File.basename(abs_path))
        abs_pn = Pathname.new(abs_path)
        rel_paths << abs_pn.relative_path_from(root_pn).to_path
      end
    end
  end
  return rel_paths.sort_by(&:downcase)
end

def get_source(rel_path)
  return File.join(ROOT_DIR, rel_path)
end

def get_target(rel_path)
  return File.join(HOME_DIR, ".#{rel_path}")
end

def smart_symlink(source, target)
  if File.exist?(target)
    if File.symlink?(target)
      link_source = File.readlink(target)
      if source == link_source
        return
      else
        log_rm_ln(link_source, target) unless source == link_source
        FileUtils.rm(target)
      end
    else
      if ask_rm_rf(target)
        log_rm_rf(target)
        FileUtils.rm_rf(target)
      else
        return
      end
    end
  end
  log_ln(source, target)
  FileUtils.symlink(source, target)
end

desc "install and configure dotfiles"
task :default => [:install, :post_install]

desc "symlink dotfiles to the user's home directory"
task :install => :prepare do
  get_relative_paths(ROOT_DIR, BASEDIRS, EXCLUDES).each do |rel_path|
    smart_symlink(get_source(rel_path), get_target(rel_path))
  end
end

desc "prepare to symlink dotfiles"
task :prepare do
  sh "git submodule update --init --recursive"
  # create directories
  BASEDIRS[1, BASEDIRS.size].each do |rel_path|
    target = get_target(rel_path)
    if File.exists?(target)
      if File.directory?(target)
        next
      elsif File.symlink?(target)
        log_rm_ln(File.readlink(target), target)
        FileUtils.rm(target)
      else
        if ask_rm_rf(target)
          log_rm_rf(target)
          FileUtils.rm_rf(target)
        else
          next
        end
      end
    end
    log_mkdir(target)
    FileUtils.mkdir(target)
  end
end

desc "all configuration that can only be run after install"
task :post_install => [:cache_fonts, :get_vim_plugins]

desc "run fc-cache"
task :cache_fonts do
  sh("fc-cache -vf #{HOME_DIR}/.fonts")
end

desc "download all Vim plugins"
task :get_vim_plugins do
  sh("vim +PlugUpgrade +PlugUpdate! +PlugClean +qall")
end

desc "remove all symlinked dotfiles"
task :remove do
  get_relative_paths(ROOT_DIR, BASEDIRS, EXCLUDES).each do |rel_path|
    target = get_target(rel_path)
    if File.symlink?(target)
      log_rm_ln(File.readlink(target), target)
      FileUtils.rm_rf(target)
    end
  end
end
