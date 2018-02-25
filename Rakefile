# Standard Rakefile for NTTE Storage Engineering
# @author Cristobal Garcia
# @version 0.1

# Build tasks
require 'bundler/gem_tasks'
# Remove install and release bundler tasks to 
# mitigate the risk of having uncontrolled gems 
# published to rubygems

Rake::Task["release"].clear
Rake::Task["install"].clear


# Documentation tasks
task :doc => ['doc:generate']
namespace :doc do
  project_root = File.expand_path(File.join(File.dirname(__FILE__), '.'))
  doc_dir = File.join(project_root,'doc')
  begin
    require 'yard'
    require 'yard/rake/yardoc_task'

    YARD::Rake::YardocTask.new(:generate) do |t|
      t.files   = ['lib/**/*.rb']   # optional
      t.options = ['--main','README.md','--output-dir',doc_dir,
                   '--markup','markdown','--markup-provider','kramdown'] 
    end
  rescue LoadError
    abort "Please, install YARD gem to generate the documentation"
  end

  desc "Remove documentation"
  task :clean do
    rm_r doc_dir if File.exists?(doc_dir)
  end
end

# General testing tasks

# RSpec
namespace :rspec do
  require 'rspec/core/rake_task'
  desc <<-EOF
    Unit testing from the CLI.

    COVERAGE=on enables SimpleCov coverage analysis
    RSPEC_FORMAT=[progress]|documentation|html
    RSPEC_OUT=file to write the report
    RSPEC_COLOR=[y]|n
  EOF
  

  RSpec::Core::RakeTask.new(:term) do |rs|
    rspec_format = ENV['RSPEC_FORMAT']||'progress'
    rspec_color = (ENV['RSPEC_COLOR']||'y') == 'y'
    #rs.ruby_opts = %w(-w )
    rs.rspec_opts = ['--format',rspec_format]
    if rspec_color
      rs.rspec_opts << %w(--tty --color)
    end
    if ENV['RSPEC_OUT']
      rs.rspec_opts << ['--out',ENV['RSPEC_OUT']]
    end
    rs.pattern = 'spec/**/*_spec.rb'
  end

  require 'ci/reporter/rake/rspec'   
  desc <<-EOF
    Unit testing under CI environments (e.g. Jenkins)

    COVERAGE=on enables SimpleCov coverage analysis
  EOF
  RSpec::Core::RakeTask.new(:ci=>'ci:setup:rspec') do |rs|
    rs.pattern = 'spec/**/*_spec.rb'
  end
end

# Cucumber
namespace :cucumber do
  begin
    require 'cucumber/rake/task'
    require 'ci/reporter/rake/cucumber'
    desc <<-EOF
      Execute cucumber features from the CLI
    EOF
    Cucumber::Rake::Task.new(:term) do |cu|
      cu.cucumber_opts = "--format progress"
    end

    desc <<-EOF
      Execute cucumber features from an integration system
    EOF

    Cucumber::Rake::Task.new(:ci=>'ci:setup:cucumber') 

  rescue LoadError
    puts "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

namespace :test do
  desc "Runs all tests for the terminal environment"
  task :term => ["rspec:term","cucumber:term"]

  desc <<-EOF
    Runs all tests for a CI environment

    COVERAGE=on will kick off the code coverage mechanisms
  EOF
  task :ci => ["rspec:ci","cucumber:ci"]
end

# Quality assurance
namespace :qa do
  namespace :flog do
    require 'flog'
    require 'flog_task'
    desc 'Analyze code complexity'
    FlogTask.new(:report) do |ft|
      ft.verbose = true
      ft.dirs = ['lib']
    end
  end
  namespace :flay do
    require 'flay'
    require 'flay_task'
    desc 'Analyze code structural similarities'
    FlayTask.new(:report) do |ft|
      ft.verbose = true
      ft.dirs = ['lib']
    end
  end
  namespace :rubocop do
    require 'rubocop' 
    require 'rubocop/rake_task'
    require 'rubocop/formatter/checkstyle_formatter'
    desc <<-EOF
      Generates a RuboCop report

      Options:
      RC_FORMAT=[simple]|progress|clang|fuubar|emacs|files|json|offenses|RuboCop::Formatter::CheckstyleFormatter
      RC_OUT=output file for the report
    EOF
    RuboCop::RakeTask.new(:report) do |rt|
      rt.patterns = ['lib/**/*.rb']
      rt.fail_on_error = false
      rc_format = ENV['RC_FORMAT'] || 'simple'
      rt.formatters = [rc_format]
      rc_out = ENV['RC_OUT']
      if rc_out
        rt.options = ['--out',rc_out]
      end
    end
  end
end

# Misc tasks
namespace :info do
  desc 'List loaded gems (useful to verify bundle exec)'
  task :gemlist do |t|
    Gem.loaded_specs.values.
      map {|x| "#{x.name} #{x.version}"}.each {|x| puts x}
  end
end

