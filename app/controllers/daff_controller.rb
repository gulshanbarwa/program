class DaffController < ApplicationController
	def index
	end


	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path, notice: "user created successfully"
		else
			render :new
		end
	end

	def login
		if session[:user_id]
			@user = User.find(session[:user_id])
			redirect_to root_path, notice: "already login"
		else
			@user =User.new
		end
	end

	def login_attempt
		@user = User.find_by(email: params[:user][:email])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to data_path, notice: "login successfully"
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to root_path, notice: "logout"
	end

	def data_new
		if session[:user_id]
			@datum = Datum.new
		end
	end

	def data
		if session[:user_id]
			@datum = Datum.new(datum_params)
			if @datum.save
				@user = User.find(session[:user_id])
				@email = @user.email
				SendMailer.send_mailer(@datum,@email).deliver_now
				redirect_to show_path, notice: "data create"
			end
		else
			redirect_to root_path, notice: "data not created"
		end
	end

	def show
		if session[:user_id]
			@user = User.find(session[:user_id])
			@datum = Datum.all
		else
			redirect_to root_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :contact, :email, :password)
	end

	def datum_params
		params.require(:datum).permit(:plan)
	end
end