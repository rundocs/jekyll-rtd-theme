source "https://rubygems.org" # source "https://gems.ruby-china.com"

gemspec


# Liquid Exception: undefined method `tainted?' for nil:NilClass in assets/404.liquid
# bundler: failed to load command: jekyll (/opt/homebrew/lib/ruby/gems/3.2.0/bin/jekyll)
# /opt/homebrew/lib/ruby/gems/3.2.0/gems/liquid-4.0.3/lib/liquid/variable.rb:124:in `taint_check': undefined method `tainted?' for nil:NilClass (NoMethodError)

#       return unless obj.tainted?
#                        ^^^^^^^^^

gem "github-pages", group: :jekyll_plugins


# in your Gemfile
# <https://github.com/jekyll/jekyll/issues/9231#issuecomment-1407643624>

# gem "jekyll", github: "jekyll/jekyll", ref: "refs/pull/9248/head"

gem "webrick", "~> 1.8"

gem "jekyll", "~> 3.9"
