require 'rails_helper'

# So specs will run and not throw scary errors before UsersController is implemented
begin
  UsersController
rescue
  UsersController = nil
end

RSpec.describe UsersController, :type => :controller do
  describe "GET #new" do
    it "renders the new users template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's username and password" do
        post :create, user: {nickname: "jack_bruce", password: ""}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, user: {nickname: "jack_bruce", password: "short"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to todo lists index on success" do
        post :create, user: {nickname: "jack_bruce", password: "password"}
        expect(response).to redirect_to(todo_lists_url)
      end

      it "logs in the user" do
        post :create, user: {nickname: "jack_bruce", password: "abcdef"}
        user = User.find_by_nickname("jack_bruce")

        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end
end
