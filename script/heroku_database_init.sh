heroku pg:reset DATABASE --app memberbook-dev
heroku run rake db:migrate --app memberbook-dev
heroku run rake db:seed --app memberbook-dev
