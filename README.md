# Verify OIDC Proxy Spike

This repository contains the outcomes of a spike looking at creating a service
that acts as a OIDC Proxy to Verify.

The service is a rails application that uses [doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) and [doorkeeper-openid_connect](https://github.com/doorkeeper-gem/doorkeeper-openid_connect) to provide the behaviours necessary for a OpenID Provider. It also implements a very rough client to the [Verify Service Provider](https://github.com/alphagov/verify-service-provider) to enable integration with Verify.

## Running

To run the service:

1. install Ruby 2.4 
1. run `bundle install` to install the gems
1. run `bundle exec rake db:migrate` to create the database
1. run `bundle exec rake db:seed` to install seeds on the database
1. run `bundle exec rails s` to run the service
