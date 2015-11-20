class RegistrationsController < Devise::RegistrationsController

	protected
	
    def after_inactive_sign_up_path_for(resource)
		new_account_path
    end

	def after_sign_up_path_for(resource)
		new_account_path
    end

    def after_sign_in_path_for(resource)
    	dashboard_index_path
    end
end