require 'user_account_repository'


RSpec.describe UserAccountRepository do

    def reset_user_accounts_table
        seed_sql = File.read('spec/seeds_user_accounts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end
  
 
    before(:each) do
      reset_user_accounts_table
    end



# 1
# Get all user accounts
    it "gets all user accounts" do
        repo = UserAccountRepository.new

        users = repo.all

        expect(users.length).to eq 2
        expect(users[0].id).to eq '1'
        expect(users[0].email_address).to eq 'makers@abc.com'
        expect(users[0].username).to eq 'MakersAbc'
        expect(users[1].id).to eq '2'
        expect(users[1].email_address).to eq 'hello@work.com'
        expect(users[1].username).to eq 'Potato123'
    end

# # 2
# # Get a single user account
    it "gets the user account with id 1" do
        repo = UserAccountRepository.new

        user = repo.find(1)

        expect(user.id).to eq '1'
        expect(user.email_address).to eq 'makers@abc.com'
        expect(user.username).to eq 'MakersAbc'
    end

# #Add another user
    it "adds another user" do
        repo = UserAccountRepository.new
        new_user = UserAccount.new
        new_user.email_address = 'blahblah@gmail.com'
        new_user.username = 'Blah222'

        repo.create(new_user)

        expect(repo.all).to include(
            have_attributes(email_address: new_user.email_address, username: new_user.username)
        )
    end

# #Update existing user
    it "updates existing user" do
        repo = UserAccountRepository.new

        user = repo.find(1)
        user.email_address = 'newemail@email.com'
        user.username = 'UpdatedUsername'

        repo.update(user)

        updated_user = repo.find(1)

        expect(updated_user.email_address).to eq 'newemail@email.com'
        expect(updated_user.username).to eq 'UpdatedUsername'
    end

# #Delete user
    it "deletes a user" do
        repo = UserAccountRepository.new

        id_to_delete = 1

        repo.delete(id_to_delete)

        users = repo.all
        expect(users.length).to eq 1
        expect(users.first.id).to eq '2'
    end 
end