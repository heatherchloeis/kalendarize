class StreamsController < ApplicationController
	before_action :set_stream,												only: [:edit, :update, :destroy]
	before_action :logged_in_user, :streamer_user,		only: [:new, :create, :edit, :update, :destroy]
	before_action :correct_user,											only: [:edit, :update, :destroy]

	def index
		@streams = Stream.all
	end

	def show
		@stream = Stream.find(params[:id])
		render 'partials/stream'
	end

	def new
	end

	def create
		@stream = current_user.streams.build(stream_params)
		if @stream.save
			flash[:success] = "Congrats (ﾉ●ω●)ﾉ*:･ﾟ✧ You've Successfully Created A Stream Time"
		else
			flash[:danger] = "Oh no (づಠ╭╮ಠ)づ Something Seems to Have Gone Wrong with Your Submission! Please Try Again"
			@schedule_items = []
		end
		redirect_back_or root_url
	end

	def edit
	end

	def update
		if @stream.update_attributes(stream_params)
			flash[:success] = "Congrats (ﾉ●ω●)ﾉ*:･ﾟ✧ You've Successfully Edited Your Stream Time"
		else
			flash[:danger] = "Oh no (づಠ╭╮ಠ)づ Something Seems to Have Gone Wrong with Your Submission! Please Try Again"
		end
		redirect_back_or root_url
	end

	def destroy
		@stream.destroy
		flash[:success] = "The Stream Time Has Been Successfully Deleted o(╥﹏╥)o"
		redirect_to request.referrer || root_url
	end

	private
		def stream_params
			params.require(:stream).permit(:day,
																		 :start_time,
																		 :end_time)
		end

		def set_stream
			@stream = Stream.find(params[:id])
		end

		def correct_user
			@stream = current_user.streams.find_by(id: params[:id])
			redirect_to root_url if @stream.nil?
		end
end
