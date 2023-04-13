ActiveAdmin.register User do
  permit_params :name, :email, :contact, :password

  index do
    selectable_column
    id_column
    column :name
    column :contact
    column :email
    actions
  end

  filter :name
  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :contact
      f.input :email
      f.input :password
    end
    f.actions
  end

  controller do
    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User updated successfully."
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :contact, :password)
    end
  end
end
