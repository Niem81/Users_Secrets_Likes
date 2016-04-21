require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	before do
	    @user = create_user
	    log_in @user
	    @secret = @user.secrets.create(content: "secret")
	end
	describe "when not logged in" do
	    before do
	      session[:user_id] = nil
	    end
	  #   it "cannot access index" do
	  #     	visit '/secrets'
			# expect(current_path).to eq('/sessions/new')
	  #   end
	    it "cannot access create" do 
	      	post :create
	      	expect(response).to redirect_to("/sessions/new")      
	    end

	    it "cannot access destroy" do
	      	delete :destroy, id: @like
	    end
	    it "makes a like and unlike" do
	    	log_in @user
	    	visit '/secrets'
		    expect(page).to have_text(@secret.content)
		    expect(page).to have_button('Like')
			click_button 'Like'
		    expect(current_path).to eq('/secrets')
		    expect(page).to have_text('1 likes')
			expect(page).to have_button('Unlike')
			click_button 'Unlike'
			expect(page).to have_text('0 likes')
		end
	end

	describe "when signed in as the wrong user" do
	    before do
	      @wrong_user = create_user 'julius', 'julius@lakers.com'
	      session[:user_id] = @wrong_user.id
	      @secret = @user.secrets.create(content: 'Ooops')
	      @like = Like.create(user: @user, secret: @secret)
	    end
	    it "cannot access destroy" do
	      delete :destroy, id: @like, user_id: @user, secret_id: @secret
	      expect(response).to redirect_to("/users/#{@wrong_user.id}")
	    end
	    puts "Passed when logg wrong_user"
	end
end
