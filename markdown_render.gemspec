# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markdown_render/version'

Gem::Specification.new do |spec|
  spec.name          = "markdown_render"
  spec.version       = Markdown::VERSION
  spec.authors       = ["Jesse Herrick"]
  spec.email         = ["jessegrantherrick@gmail.com"]
  spec.summary       = %q{A themed markdown processor.}
# spec.description   = ""
  spec.homepage      = "https://github.com/JesseHerrick/markdown_render"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mercenary"
  spec.add_runtime_dependency "kramdown"
  spec.add_runtime_dependency "redcarpet"
  spec.add_runtime_dependency "rdiscount"
  spec.add_runtime_dependency "github-markdown"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
