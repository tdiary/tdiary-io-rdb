# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "tdiary-io-rdb"
  spec.version       = "0.0.2"
  spec.authors       = ["SHIBATA Hiroshi"]
  spec.email         = ["shibata.hiroshi@gmail.com"]
  spec.summary       = %q{rdb adapter for tDiary}
  spec.description   = %q{rdb adapter for tDiary}
  spec.homepage      = "https://github.com/tdiary/tdiary-io-rdb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sequel"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
