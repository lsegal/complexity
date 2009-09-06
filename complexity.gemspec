SPEC = Gem::Specification.new do |s|
  s.name = "complexity"
  s.version = "1.0.0"
  s.date = "2009-09-05"
  s.author = "Loren Segal"
  s.email = "lsegal@soen.ca"
  s.homepage = "http://github.com/lsegal/complexity"
  s.rubyforge_project = 'complexity'
  s.platform = Gem::Platform::RUBY
  s.summary = "Calculates"
  s.files = Dir.glob("{lib,bin,test}/**/*") + ['LICENSE', 'README.md', 'Rakefile']
  s.test_files = ['test/test_complexity.rb']
  s.require_paths = ['lib']
  s.executables = ['complexity']
  s.has_rdoc = 'yard'
  s.add_dependency 'yard'
end