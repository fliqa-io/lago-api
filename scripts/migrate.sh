#!/bin/bash
set -e

if [ "$RAILS_ENV" == "staging" ]
then
  bundle exec rake db:prepare
else
  # The create db is disabled we only need to migrate the database
  # bundle exec rake db:create
  bundle exec rails db:migrate

  if [ -v LAGO_CREATE_ORG ] && [ "$LAGO_CREATE_ORG" == "true" ]
  then
    bundle exec rails signup:seed_organization
  fi
fi

echo "✅ Migrations completed successfully."
exit 0  # Explicitly return success