require 'bundler/setup'

Bundler.require(:default, :test)

require (Pathname.new(__FILE__).dirname + '../lib/suspenders').expand_path

Dir['./spec/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.include SuspendersTestHelpers

  config.before(:all) do
    create_tmp_directory
  end

  config.before(:each) do
    FakeHeroku.clear!
    FakeGithub.clear!
  end
end

RSpec::Matchers.define :be_in_the_gemfile do |expected|
  match do |gem_name|
    gemfile = File.open(File.join(project_path, 'Gemfile'), 'r')

    File.foreach(gemfile).any? do |line|
      line.match(/#{Regexp.quote(gem_name)}/)
    end
  end
end

