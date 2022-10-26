require_relative 'user_account'

class UserAccountRepository
    # Selecting all records
# No arguments
def all
    sql = 'SELECT id, email_address, username FROM user_accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |record|
        user = UserAccount.new
        user.id = record["id"]
        user.email_address = record["email_address"]
        user.username = record["username"]
    users << user
    end

    return users
end

# Gets a single record by its ID
# One argument: the id (number)
def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, email_address, username FROM user_accounts WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    user = UserAccount.new
    user.id = record["id"]
    user.email_address = record["email_address"]
    user.username = record["username"]

    return user

end

# Add more methods below for each operation you'd like to implement.

def create(user_account)
# Executes the SQL query:
    sql = 'INSERT INTO user_accounts (email_address, username) VALUES ($1, $2);'
    params = [user_account.email_address, user_account.username]

    result_set = DatabaseConnection.exec_params(sql, params)
    return nil
end

def update(user_account)
    sql = 'UPDATE user_accounts SET email_address = $1, username = $2 WHERE id = $3;'
    params = [user_account.email_address, user_account.username, user_account.id]

    DatabaseConnection.exec_params(sql, params)
    return nil
end

 def delete(id)
    sql = 'DELETE FROM user_accounts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)
    return nil
 end


end