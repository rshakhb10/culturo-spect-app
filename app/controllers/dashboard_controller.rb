class DashboardController < ApplicationController
	def index
		@account = current_user.account
		@last_accounts = Account.last(10).reverse!
	end

	def show
		@account = current_user.account
	end

	def search

		if params[:city].present? and !params[:keyword].present? and !params[:zipcode].present?
	      if params[:user_type] == "1"
	      	@accounts = Account.where('city like ?', params[:city])

		  elsif params[:user_type] == "2"
		    @accounts = Account.where('city like ? and new_arrival=?', params[:city], true)

		  elsif params[:user_type] == "3"
		    @accounts = Account.where('city like ? and new_arrival=?', params[:city], false)
		  end
        
        elsif params[:city].present? and params[:keyword].present? and !params[:zipcode].present?
          if params[:user_type] == "1"
            @accounts = Account.where('city like ? and story like ?', params[:city], "%"+params[:keyword]+"%")
          elsif params[:user_type] == "2"
		    @accounts = Account.where('city like ? and new_arrival=? and story like ?', params[:city], true, "%"+params[:keyword]+"%")

		  elsif params[:user_type] == "3"
		    @accounts = Account.where('city like ? and new_arrival=? and story like ?', params[:city], false, "%"+params[:keyword]+"%")
          end

        elsif !params[:city].present? and params[:keyword].present? and !params[:zipcode].present?
          if params[:user_type] == "1"
            @accounts = Account.where('story like ?', "%"+params[:keyword]+"%")
          elsif params[:user_type] == "2"
		    @accounts = Account.where('new_arrival=? and story like ?', true, "%"+params[:keyword]+"%")

		  elsif params[:user_type] == "3"
		    @accounts = Account.where('new_arrival=? and story like ?', false, "%"+params[:keyword]+"%")
          end	
	
	    elsif params[:city].present? and params[:zipcode].present?
	    	flash[:search_error] = "Please enter either city or zipcode but not both."
	        redirect_to dashboard_index_path

	    elsif !params[:city].present? and !params[:keyword].present? and params[:zipcode].present?
          if params[:user_type] == "1"
	    	@accounts = Account.near(params[:zipcode], params[:distance])
	      elsif params[:user_type] == "2"
	        @accounts = (Account.near(params[:zipcode], params[:distance]).where('new_arrival=?', true))
	      elsif params[:user_type] == "3"
	        @accounts = (Account.near(params[:zipcode], params[:distance]).where('new_arrival=?', false))
          end

	    elsif !params[:city].present? and params[:keyword].present? and params[:zipcode].present?
          if params[:user_type] == "1"
	    	@accounts = Account.near(params[:zipcode], params[:distance]).where('story like ?', "%"+params[:keyword]+"%")
	      elsif params[:user_type] == "2"
	        @accounts = Account.near(params[:zipcode], params[:distance]).where('new_arrival=? and story like ?', true, "%"+params[:keyword]+"%")
	      elsif params[:user_type] == "3"
	        @accounts = Account.near(params[:zipcode], params[:distance]).where('new_arrival=? and story like ?', false, "%"+params[:keyword]+"%")
          end

	    elsif !params[:city].present? and !params[:keyword].present? and !params[:zipcode].present?
	        flash[:search_error] = "Enter at least one of these: city or zipcode or keyword"
	        redirect_to dashboard_index_path
	    end
			
	end

end