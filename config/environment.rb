require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/ecomcharge_test'
require_relative '../apps/web/application'
require "hanami/middleware/body_parser"

Hanami.configure do
  middleware.use Hanami::Middleware::BodyParser, :json
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/ecomcharge_test_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/ecomcharge_test_development'
    #    adapter :sql, 'mysql://localhost/ecomcharge_test_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []
  end
end
