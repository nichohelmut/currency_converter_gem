
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "currency_converter_gem_nichohelmut/version"

Gem::Specification.new do |spec|
  spec.name          = "currency_converter_gem_nichohelmut"
  spec.version       = CurrencyConverterGemNichohelmut::VERSION
  spec.authors       = ["Nicholas Utikal"]
  spec.email         = ["nicholasutikal@gmail.com"]

  spec.summary       = %q{A gem to perform currency conversion and arithmetics with different currenciesS}
  spec.homepage      = "https://github.com/nichohelmut/currency_converter_gem"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
