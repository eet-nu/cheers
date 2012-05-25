require 'rb-readline'

guard 'bundler' do
  watch('Gemfile')
  watch('cheers.gemspec')
end

guard 'rspec', version: 2, cli: '--format Fuubar --colour' do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{lib/.+\.rb})        { "spec" }
  watch('spec/spec_helper.rb') { "spec" }
end
