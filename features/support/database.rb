# Configure how cucumber deals with data stored in the test database.

# Remove/comment out the lines below if your app doesn't have a database.
DatabaseCleaner.strategy = :transaction

# Possible values are :truncation and :transaction. The :transaction strategy
# is faster, but might give you threading problems. See http://goo.gl/QqxPl
Cucumber::Rails::Database.javascript_strategy = :truncation
