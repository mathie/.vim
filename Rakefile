require 'rubygems'
require 'rake'

task :default => :update

desc "Symlink all the vendored plugins into where vim loads them"
task :symlink do
  sh "find . -type l | xargs rm"
  plugin_directories.each do |plugin_directory|
    plugin_subdirs(plugin_directory).each do |dir|
      top_level_dir = File.basename(dir)
      Dir.mkdir(top_level_dir) unless File.directory?(top_level_dir)
      Dir.chdir(top_level_dir) do
        Dir["../#{dir}/*"].each do |file|
          File.symlink(file, File.basename(file)) unless File.exists?(File.basename(file))
        end
      end
    end
  end
end

desc "Update vendored plugins to latest upstream"
task :update do
  plugin_directories.each do |plugin_directory|
    Dir.chdir(plugin_directory) do
      sh 'git remote update; git reset --hard origin/master'
    end if File.exists?("#{plugin_directory}/.git")
  end
  Rake::Task["symlink"].invoke
end

def plugin_directories
  Dir['vendor/plugins/*']
end

def plugin_subdirs(plugin_directory)
  Dir["#{plugin_directory}/*"].select { |d| File.directory?(d) }
end
