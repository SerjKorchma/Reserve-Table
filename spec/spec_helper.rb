# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'spork'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

Spork.prefork do
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  RSpec.configure do |config|
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"


    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # RSpec Rails can automatically mix in different behaviours to your tests
    # based on their file location, for example enabling you to call `get` and
    # `post` in specs under `spec/controllers`.
    #
    # You can disable this behaviour by removing the line below, and instead
    # explicitly tag your specs with their type, e.g.:
    #
    #     RSpec.describe UsersController, :type => :controller do
    #       # ...
    #     end
    #
    # The different available types are documented in the features, such as in
    # https://relishapp.com/rspec/rspec-rails/docs
    config.infer_spec_type_from_file_location!

    # These two settings work together to allow you to limit a spec run
    # to individual examples or groups you care about by tagging them with
    # `:focus` metadata. When nothing is tagged with `:focus`, all examples
    # get run.
    # config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus
    config.run_all_when_everything_filtered = true


    # Many RSpec users commonly either run the entire suite or an individual
    # file, and it's useful to allow more verbose output when running an
    # individual spec file.
    if config.files_to_run.one?
      # Use the documentation formatter for detailed output,
      # unless a formatter has already been configured
      # (e.g. via a command-line flag).
      config.default_formatter = 'doc'
    end

    # Print the 10 slowest examples and example groups at the
    # end of the spec run, to help surface which specs are running
    # particularly slow.
    config.profile_examples = 10

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = :random

    # Seed global randomization in this process using the `--seed` CLI option.
    # Setting this allows you to use `--seed` to deterministically reproduce
    # test failures related to randomization by passing the same `--seed` value
    # as the one that triggered the failure.

    # rspec-expectations config goes here. You can use an alternate
    # assertion/expectation library such as wrong or the stdlib/minitest
    # assertions if you prefer.
    config.expect_with :rspec do |expectations|
      # Enable only the newer, non-monkey-patching expect syntax.
      # For more details, see:
      #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
      expectations.syntax = :expect
    end

    # rspec-mocks config goes here. You can use an alternate test double
    # library (such as bogus or mocha) by changing the `mock_with` option here.
    # config.mock_with :rspec do |mocks|
    #   # Enable only the newer, non-monkey-patching expect syntax.
    #   # For more details, see:
    #   #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    #   mocks.syntax = :expect
    #
    #   # Prevents you from mocking or stubbing a method that does not exist on
    #   # a real object. This is generally recommended.
    #   mocks.verify_partial_doubles = true
    # end


    # config.include EmailSpec::Helpers
    # config.include EmailSpec::Matchers
    config.include Rails.application.routes.url_helpers
    config.include FactoryGirl::Syntax::Methods


    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, js: true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
      # FakeWeb.clean_registry
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  FactoryGirl.reload
end
