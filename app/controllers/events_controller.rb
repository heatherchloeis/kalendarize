class EventsController < ApplicationController
	before_action :set_event,													only: [:edit, :update, :destroy]
	before_action :logged_in_user, :streamer_user,		only: [:new, :create, :edit, :update, :destroy]
	before_action :correct_user,											only: [:edit, :update, :destroy]

	def index
		@events = Event.all
	end

	def show
		@event = Event.find(params[:id])
		render 'partials/event'
	end

	def new
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash[:success] = "Congrats (ﾉ●ω●)ﾉ*:･ﾟ✧ You've Successfully Created An Event"
		else
			flash[:danger] = "Oh no (づಠ╭╮ಠ)づ Something Seems to Have Gone Wrong with Your Submission! Please Try Again"
			# @schedule_items = []
		end
		redirect_back_or root_url
	end

	def edit
	end

	def update
		if @event.update_attributes(event_params)
			flash[:success] = "Congrats (ﾉ●ω●)ﾉ*:･ﾟ✧ You've Successfully Edited Your Event"
		else
			flash[:danger] = "Oh no (づಠ╭╮ಠ)づ Something Seems to Have Gone Wrong with Your Submission! Please Try Again"
		end
		redirect_back_or root_url
	end

	def destroy
		@event.destroy
		flash[:success] = "The Event Has Been Successfully Deleted o(╥﹏╥)o"
		redirect_to request.referrer || root_url
	end

	private
		def event_params
			params.require(:event).permit(:event_day,
																		:event_start,
																		:event_end,
																		:event_title,
																		:event_description)
		end

		def set_event
			@event = Event.find(params[:id])
		end

		def correct_user
			@event = current_user.events.find_by(id: params[:id])
			redirect_to root_url if @event.nil?
		end
end
