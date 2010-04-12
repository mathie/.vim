require 'rubygems'
require 'rake'

task :default => :symlink

task :symlink do
  Dir['vendor/plugins/*'].each do |plugin|
    Dir["#{plugin}/*"].select { |d| File.directory?(d) }.each do |dir|
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

task :update do
  Dir['vendor/plugins/*'].each do |plugin|
    Dir.chdir(plugin) do
      sh 'git pull'
    end if File.directory?("#{plugin}/.git")
  end
  Rake::Task["symlink"].invoke
end
