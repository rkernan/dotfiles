require 'highline/import'
require 'pathname'

@verbose_log = (verbose == true) || (Rake.application.options.trace == true)
RakeFileUtils.verbose_flag = false unless @verbose_log

ROOT_DIR = File.expand_path(File.dirname(__FILE__))
HOME_DIR = ENV['HOME']

BASEDIRS = [".", "config", "fonts", "share"]
EXCLUDES = (["Rakefile", "README.md"] + [BASEDIRS[1, BASEDIRS.size]]).flatten

def log(msg, prefix, stream = $stdout)
  stream.puts("#{prefix} #{msg}")
end

def log_ln(source, target)
  log("Created symlink: #{source} -> #{target}", "+")
end

def log_rm_ln(source, target)
  log("Removed symlink: #{source} -> #{target}", "-")
end

def log_mkdir(dir)
  log("Create directory: #{dir}", "+")
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
      log_rm_ln(link_source, target) unless source == link_source
      FileUtils.rm(target)
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

task :default => :install

task :install => :prepare do
  get_relative_paths(ROOT_DIR, BASEDIRS, EXCLUDES).each do |rel_path|
    smart_symlink(get_source(rel_path), get_target(rel_path))
  end
end

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

task :cache_fonts do
  sh "fc-cache -vf #{HOME_DIR}/.fonts"
end

task :get_plugins do
  sh "vim +qall"
end

task :compile_ycm do
  # generate flags
  flags = ""
  if ask_yn("Build semantic completion for C-family languages?")
    flags += " --clang-completer"
    if ask_yn "Use system libclang?"
      flags += " --system-libclang"
    end
  end
  if ask_yn("Build semantic completion for C#?")
    flags += " --omnisharp-completer"
  end
  # buld
  Dir.chdir("#{ROOT_DIR}/vim/bundle/YouCompleteMe")
  sh("./install.sh #{flags}")
  Dir.chdir(ROOT_DIR)
end

task :remove do
  get_relative_paths(ROOT_DIR, BASEDIRS, EXCLUDES).each do |rel_path|
    target = get_target(rel_path)
    if File.symlink?(target)
      log_rm_ln(File.readlink(target), target)
      FileUtils.rm_rf(target)
    end
  end
end
