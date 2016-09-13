require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new users page" do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
    it "renders the users page" do
      get :index
      expect(response).to render_template("index")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "renders the user show page" do
        post :create, user: {username: "username", password: "password"}
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "renders the users page" do
        post :create, user: {username: "username"}
          expect(response).to render_template("new")
          expect(flash[:errors]).to be_present
      end
    end
  end


end
