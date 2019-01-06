class Stream < ApplicationRecord
  validates :user_id, 		presence: true
  validates :day,					presence: true
  validates :start_time,	presence: true
  validates :end_time,		presence: true

  validate  :valid_time_slot

  validates :start_time, :end_time, :overlap => { :scope => [:user_id, :day], :load_overlapped => true }

  belongs_to :user, -> { where(streamer: true) }

  default_scope -> { order(day: :asc, start_time: :asc, end_time: :asc) }

  private
  	def valid_time_slot
	  	if start_time == nil
	  		errors.add(:start_time, "Please Enter A Start Time (ﾉಠ_ಠ)ﾉ 彡 ┻━┻")
	  	elsif end_time == nil
	  		errors.add(:end_time, "Please Enter A End Time (ﾉಠ_ಠ)ﾉ 彡 ┻━┻")
  		else
	  		if end_time <= start_time
	  			errors.add(:end_time, "Streams Can't Time Travel (づಠ╭╮ಠ)づ Please Try Again")
	  		end
	  	end
  	end
end