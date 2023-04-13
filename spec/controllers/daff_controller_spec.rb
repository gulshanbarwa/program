require 'rails_helper'
RSpec.describe DaffController, type: :controller do
  describe "root daff#index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "get #new" do
    it "assigns new instance variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
    let(:valid_params) { { user: { name: "John Doe",contact: "1234567890", email: "john@example.com", password: "password" } } }

    context "with valid parameters" do
      it "creates a new user" do
        expect { post :create, params: valid_params }.to change { User.count }.by(1)
      end

      it "sets a success notice" do
        post :create, params: valid_params
        expect(flash[:notice]).to eq("user created successfully")
      end
    end
    context "with invalid parameters" do
      let(:invalid_params) { { user: { email: "invalid_email" } } }

      it "does not create a new user" do
        expect { post :create, params: invalid_params }.to_not change { User.count }
      end


      it "redirects to the root path" do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe "#login" do
    context "when user is already logged in" do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
      end

      it "redirects to root_path with notice" do
        get :login
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("already login")
      end
    end

    context "when user is not logged in" do
      it "assigns a new user to @user" do
        get :login
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
   describe "#login_attempt" do
    let!(:user) { create(:user) }
    let(:valid_params) { { user: { email: user.email, password: user.password } } }

    context "with valid parameters" do
      before { post :login_attempt, params: valid_params }

      it "redirects to the data page" do
        expect(response).to redirect_to(data_path)
      end

      it "sets a notice" do
        expect(flash[:notice]).to eq("login successfully")
      end

      it "sets the session user_id" do
        expect(session[:user_id]).to eq(user.id)
      end
    end
  end
  describe "#logout" do
    it "logout user by clearing session user id" do
      get :logout
      expect(session[:user_id]).to be_nil
    end
    it "redirect user to root_path" do
      get :logout
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("logout")
    end
  end

  describe "#data_new" do
    context "when user is logged in" do
      let(:user) { create(:user) }
      
      before do
        session[:user_id] = user.id
        get :data_new
      end
      
      it "assigns a new instance of Datum to @datum" do
        expect(assigns(:datum)).to be_a_new(Datum)
      end
    end
  end

  describe "#data" do
    let(:user) { create(:user) }
    let(:datum_params) { attributes_for(:datum) }

    context "when user is logged in" do
      before { session[:user_id] = user.id }

      it "creates a new datum" do
        expect { post :data, params: { datum: datum_params } }.to change { Datum.count }.by(1)
      end

      it "redirects to root path if datum is saved" do
        post :data, params: { datum: datum_params }
        expect(response).to redirect_to(show_path)
      end
    end

    context "when user is not logged in" do
      it "redirects to root path" do
        post :data, params: { datum: datum_params }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#show" do
    let(:user) {create(:user)}
    context "if user is logged in" do
      before {session[:user_id] = user.id}

      it "assigns current user to @user" do
        get :show
        expect(assigns(:user)).to eq(user)
      end
    end
    
    context "if user is not logged in" do
      it "redirect to root_path" do
        get :show
        expect(response).to redirect_to(root_path)
      end
    end
  end


end
