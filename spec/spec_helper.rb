require 'bundler'
Bundler.require(:test)

Atlas.data_dir = File.expand_path(File.dirname(__FILE__) + '/..')
I18n.enforce_available_locales = true

# A matcher which asserts the validity of a document, providing a summary of
# the validation failures if it isn't.
RSpec::Matchers.define :be_valid do
  diffable

  failure_message do |actual|
    identify_as = (@document && @document.key.inspect) || actual
    "expected that #{identify_as} would be valid"
  end

  match do |document|
    if document.valid?
      true
    else
      # Setting @actual allows "diffable" to provide meaningful messages.
      @document = document
      @actual   = document.errors.messages
      @expected = {}

      expect(document.errors.messages).to eql({})
    end
  end
end

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # Use only the "expect" syntax.
  config.expect_with(:rspec) { |c| c.syntax = :expect }

  # Tries to find examples / groups with the focus tag, and runs them. If no
  # examples are focues, run everything. Prevents the need to specify
  # `--tag focus` when you only want to run certain examples.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
