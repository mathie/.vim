require 'rubygems'
require 'rake'
require 'fileutils'

vim = '/usr/local/bin/vim'

task :default => :update

desc "Symlink all the vendored plugins into where vim loads them"
task :symlink do
  sh "find . -type l | xargs rm"
  plugin_directories.each do |plugin_directory|
    plugin_files(plugin_directory).each do |file|
      dir = File.dirname(file.gsub(/vendor\/plugins\/[^\/]+\//, ''))
      next if ['_assets', 'etc', 'tmp', 'test', 'spec', 't', 'tests'].include?(dir.gsub(/\/.*$/, ''))
      FileUtils.mkdir_p(dir)
      Dir.chdir(dir) do
        target = File.basename(file)
        next if ['tags'].include?(target)
        source = "#{dir.gsub(/[^\/]+/, '..')}/#{file}"
        File.symlink(source, target) unless File.exists?(target)
      end
    end
  end
end

desc "Update Vim's help tags"
task :helptags do
  sh "#{vim} -u NONE -c 'helptags doc' -c q"
end

desc "Update vendored plugins to latest upstream"
task :update do
  plugin_directories.each do |plugin_directory|
    Dir.chdir(plugin_directory) do
      sh 'git remote update; git reset --hard origin/master; git clean -dxf'
    end if File.exists?("#{plugin_directory}/.git")
  end
  Rake::Task["symlink"].invoke
  Rake::Task['helptags'].invoke
end

def plugin_directories
  Dir['vendor/plugins/*']
end

def plugin_files(plugin_directory)
  FileList["#{plugin_directory}/*/**/*"].select { |f| File.file?(f) }
end
