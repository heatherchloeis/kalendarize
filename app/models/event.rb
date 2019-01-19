class Event < ApplicationRecord
  validates :user_id, 		presence: true
  validates :event_day,  	presence: true
  validates :event_start,	presence: true
  validates :event_end,		presence: true
  validates :event_title, presence: true

  validate  :valid_time_slot

  belongs_to :user, -> { where(streamer: true) }

  default_scope -> { order(event_day: :asc, event_start: :asc, event_end: :asc) }

  before_save :parse_start_and_event_end

  private
  	def valid_time_slot
	  	if event_start == nil
	  		errors.add(:event_start, "Please Enter A Start Time (ﾉಠ_ಠ)ﾉ 彡 ┻━┻")
	  	elsif event_end == nil
	  		errors.add(:event_end, "Please Enter A End Time (ﾉಠ_ಠ)ﾉ 彡 ┻━┻")
  		else
	  		if event_end <= event_start
	  			errors.add(:event_end, "Events Can't Time Travel (づಠ╭╮ಠ)づ Please Try Again")
	  		end
	  	end
  	end

    def parse_start_and_event_end
      tzone = User.find_by(id: user_id).time_zone

      t = event_start.in_time_zone(tzone).utc_offset
      offset = (t / 3600).round
      offset = offset.to_s + ":00"

      self.event_start = DateTime.new(event_day.year, event_day.month, event_day.day, event_start.hour, event_start.min, event_start.sec, offset)
     	self.event_end = DateTime.new(event_day.year, event_day.month, event_day.day, event_end.hour, event_end.min, event_end.sec, offset)
    end
end