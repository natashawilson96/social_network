# Model and Repository Classes Design Recipe

*Copy this recipe template to design and implement Model and Repository classes for a database table.*


## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```
-- EXAMPLE
-- (file: spec/seeds_user_accounts.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_address, username) VALUES ('makers@abc.com', 'MakersAbc');
INSERT INTO user_accounts (email_address, username) VALUES ('hello@work.com', 'Potato123');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```
psql -h 127.0.0.1 psql -h 127.0.0.1 social_network_test < seeds_posts.sql

```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/student.rb)
class UserAccounts
end

# Repository class
# (in lib/user_accounts_repository.rb)
class UserAccountsRepository
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)

class UserAccounts
    attr_accessor :id, :email_address, :username
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```
# EXAMPLE
# Table name: user_accounts

# Repository class
# (in lib/user_account_repository.rb)

class UserAccountsRepository
      # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts;

    # Returns an array of UserAccounts objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts WHERE id = $1;

    # Returns a single UserAccount object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(user_account)
  # Executes the SQL query:
    # INSERT INTO user_accounts (id, email_address, username) VALUES ($1, $2)
  # end

  # def update(user_account)
    # UPDATE user_accounts SET email_address = ($1) WHERE [conditions]
  # end

  # def delete(user_account)
    # DELETE FROM user_accounts WHERE [conditions]
  # end


end



```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```
# EXAMPLES

# 1
# Get all user accounts

repo = UserAccountRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  1
users[0].email_address # => 'makers@abc.com'
users[0].username # => 'MakersAbc'


users[1].id # =>  2
users[1].email_address # => 'hello@work.com'
users[1].username # =>  'Potato123'


# 2
# Get a single student

repo = UserAccountRepository.new

user = repo.find(1)

user.id # =>  1
user.email_address # =>  'makers@abc.com'
user.username # =>  'MakersAbc'

# Add more examples for each method
#Add another user

repo = UserAccountRepository.new
new_user = UserAccount.new
new_user.email_address = 'blahblah@gmail.com'
new_user.username = 'Blah222'

repo.create(new_user)

expect(repo.all).to include(have attributes(email_address: new_user.email_address, username: new_user.username))


#Update existing user
repo = UserAccountRepository.new

user = repo.find(1)
user.email_address = 'newemail@email.com'
user.username = 'UpdatedUsername'

repo.update(user)

updated_user = repo.find(1)

updated_user.email_address # => 'newemail@email.com'
updated_user.username # => 'UpdatedUsername'


#Delete user

repo = UserAccountRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

users = repo.all
users.length # => 1
users.first.id # => '2'


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```
# EXAMPLE

# file: spec/user_account_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do
    reset_students_table
  end

  # (your tests will go here).
end

```

## 8. Test-drive and implement the Repository class behaviour

*After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.*