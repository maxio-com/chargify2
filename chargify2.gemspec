Gem::Specification.new do |s|
  s.specification_version = 3 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.6.2'

  s.name    = 'chargify2'
  s.version = '0.2.2'
  s.date    = '2011-10-28'
  s.summary = %q{Chargify API V2 Ruby Wrapper}
  s.description = ''
  s.authors = ["Michael Klett", "Shay Frendt"]
  s.email = %q{michael@webadvocate.com}
  s.homepage = %q{http://github.com/chargify/chargify2}
  s.licenses = ["MIT"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w[lib]

  # Runtime Dependencies
  s.add_runtime_dependency('rack', '>= 0')
  s.add_runtime_dependency('hashery', '~> 2.0.1')
  s.add_runtime_dependency('hashie', '>= 0')
  s.add_runtime_dependency('httparty', '>= 0')

  # Development Dependencies
  s.add_development_dependency('rake', '~> 0.9.2.2')
  s.add_development_dependency('rspec', '~> 2.11.0')
  s.add_development_dependency('capybara', '>= 0')
  s.add_development_dependency('vcr', '>= 0')
  s.add_development_dependency('webmock', '>= 0')
  s.add_development_dependency('yard', '~> 0.8.0')
end
