class MessagesController < ApplicationController
	before_action :authenticate_user!


	def new
      @recipient_id = params['recipient_id']
      @recipient = User.find_by_id(params[:recipient_id])


	end

	def create
      @recipient = User.find_by_id(params[:recipient_id])
      conversation = current_user.send_message(@recipient, params[:message][:body], params[:message][:subject]).conversation
      redirect_to conversation_path(conversation)
	end

	def show
	end


end