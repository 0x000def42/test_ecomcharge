# Ecomcharge Test

It's my implementation of ecomcharge.com test task.

It's web api on default hanami setup.

How to setup:

Requirements: `ruby <= 2.5, bundler, installed postgres`

1. Clone it `git@github.com:0x000def42/test_ecomcharge.git`
2. Open dir `cd test_ecomcharge`
3. Run `bundle install`
4. Change `.env.development` and `.env.test` on you postgres creds
5. Run `HANAMI_ENV=test hanami db prepare`
6. Run `rspec`
7. Run `hanami db prepare`
8. Run `rake seed`
9. Run `rake seed_rates`
10. Run `unicorn`
11. Open another console tab
12. Run performance tests `rake perf`