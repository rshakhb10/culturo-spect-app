class AccountsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
	
	def new
		@account = Account.new
	end

	def create
		safe_account_params = params.require(:account).permit(:first_name, :last_name, 
			:date_of_birth, :city, :country, :zipcode, :new_arrival, :story)
		@account = Account.new safe_account_params
		@account.user = current_user

		if @account.save
			redirect_to @account
		else
			render :new
		end
	end

	def edit
    	@account = current_user.account
    	#@account.update params.require(@account).permit(:first_name, :last_name, 
		#	:date_of_birth, :city, :country, :zipcode, :new_arrival, :story)

    	#redirect_to @account	
    end

    def update
    	@account = current_user.account
    	safe_account_params = params.require(:account).permit(:first_name, :last_name, 
			:date_of_birth, :city, :country, :zipcode, :new_arrival, :story)
    	@account.update safe_account_params

    	if @account.save
			redirect_to @account
		else 
			render :edit
		end
    end

	def show
	  @account = current_user.account
	end


end