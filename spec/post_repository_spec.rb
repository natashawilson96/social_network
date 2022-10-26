require 'post_repository'


RSpec.describe PostRepository do

    def reset_posts_table
        seed_sql = File.read('spec/seeds_posts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end
  
 
    before(:each) do
      reset_posts_table
    end



# 1
# Get all posts
    it "gets all posts" do
        repo = PostRepository.new

        posts = repo.all

        expect(posts.length).to eq 2
        expect(posts[0].id).to eq '1'
        expect(posts[0].title).to eq 'Great'
        expect(posts[0].content).to eq 'Interesting post'
        expect(posts[0].number_of_views).to eq '120'
        expect(posts[0].user_account_id).to eq '2'
        expect(posts[1].id).to eq '2'
        expect(posts[1].title).to eq 'Not good'
        expect(posts[1].content).to eq 'Boring words'
        expect(posts[1].number_of_views).to eq '5'
        expect(posts[1].user_account_id).to eq '1'
    end

# # # 2
# # # Get a single user account
#     it "gets the user account with id 1" do
#         repo = UserAccountRepository.new

#         user = repo.find(1)

#         expect(user.id).to eq '1'
#         expect(user.email_address).to eq 'makers@abc.com'
#         expect(user.username).to eq 'MakersAbc'
#     end

# # #Add another user
#     it "adds another user" do
#         repo = UserAccountRepository.new
#         new_user = UserAccount.new
#         new_user.email_address = 'blahblah@gmail.com'
#         new_user.username = 'Blah222'

#         repo.create(new_user)

#         expect(repo.all).to include(
#             have_attributes(email_address: new_user.email_address, username: new_user.username)
#         )
#     end

# # #Update existing user
#     it "updates existing user" do
#         repo = UserAccountRepository.new

#         user = repo.find(1)
#         user.email_address = 'newemail@email.com'
#         user.username = 'UpdatedUsername'

#         repo.update(user)

#         updated_user = repo.find(1)

#         expect(updated_user.email_address).to eq 'newemail@email.com'
#         expect(updated_user.username).to eq 'UpdatedUsername'
#     end

# # #Delete user
#     it "deletes a user" do
#         repo = UserAccountRepository.new

#         id_to_delete = 1

#         repo.delete(id_to_delete)

#         users = repo.all
#         expect(users.length).to eq 1
#         expect(users.first.id).to eq '2'
#     end 
end