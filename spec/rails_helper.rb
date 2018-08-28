ENV["RAILS_ENV"] ||= "test"

require "spec_helper"
require "support/factory_bot"
require "support/capybara"
require "support/email_spec"
require "support/mailer_macros"
require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include MailerMacros
  config.before(:each) {reset_email}
  config.include ActionView::Helpers::TranslationHelper
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
