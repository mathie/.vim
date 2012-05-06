require 'rubygems'
require 'rake'
require 'fileutils'

task :default => :update

desc "Symlink all the vendored plugins into where vim loads them"
task :symlink do
  sh "find . -type l | xargs rm"
  plugin_directories.each do |plugin_directory|
    plugin_files(plugin_directory).each do |file|
      dir = File.dirname(file.gsub(/vendor\/plugins\/[^\/]+\//, ''))
      next if ['etc', 'tmp', 'test', 't'].include?(dir.gsub(/\/.*$/, ''))
      FileUtils.mkdir_p(dir)
      Dir.chdir(dir) do
        target = File.basename(file)
        source = "#{dir.gsub(/[^\/]+/, '..')}/#{file}"
        File.symlink(source, target) unless File.exists?(target)
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

def plugin_files(plugin_directory)
  FileList["#{plugin_directory}/*/**/*"].select { |f| File.file?(f) }
end
