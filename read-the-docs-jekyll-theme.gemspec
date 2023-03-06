Gem::Specification.new do |spec|
  spec.name          = "read-the-docs-jekyll-theme"
  spec.version       = "2.1"
  spec.authors       = ["JV-conseil"]
  spec.email         = ["contact@jv-conseil.net"]

  spec.summary       = "Read the Docs like Jekyll Theme for GitHub Pages"
  spec.license       = "EUPL-1.2"
  spec.homepage      = "https://github.com/JV-conseil/read-the-docs-jekyll-theme"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "github-pages", "~> 228"
end
