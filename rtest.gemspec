# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rtest}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dav\303\255\303\260 Halld\303\263r L\303\272\303\260v\303\255ksson"]
  s.autorequire = %q{rtest}
  s.date = %q{2009-11-10}
  s.default_executable = %q{rtest}
  s.description = %q{A gem that provides Ruby Selenium test skeleton project}
  s.email = %q{davidhalldor@gmail.com}
  s.executables = ["rtest"]
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["LICENSE", "README", "Rakefile", "lib/constants.rb", "lib/selenium_driver.rb", "test/new_spec.rb", "vendor/selenium-server.jar", "bin/rtest"]
  s.homepage = %q{http://github.com/davidhalldor/rtest}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A gem that provides Ruby Selenium test skeleton project}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ci_reporter>, [">= 0"])
      s.add_runtime_dependency(%q<rspec>, ["= 1.2.8"])
      s.add_runtime_dependency(%q<selenium-client>, ["= 1.2.17"])
      s.add_runtime_dependency(%q<syntax>, [">= 0"])
    else
      s.add_dependency(%q<ci_reporter>, [">= 0"])
      s.add_dependency(%q<rspec>, ["= 1.2.8"])
      s.add_dependency(%q<selenium-client>, ["= 1.2.17"])
      s.add_dependency(%q<syntax>, [">= 0"])
    end
  else
    s.add_dependency(%q<ci_reporter>, [">= 0"])
    s.add_dependency(%q<rspec>, ["= 1.2.8"])
    s.add_dependency(%q<selenium-client>, ["= 1.2.17"])
    s.add_dependency(%q<syntax>, [">= 0"])
  end
end
