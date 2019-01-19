class Stream < ApplicationRecord
  validates :user_id, 		  presence: true
  validates :stream_day,  	presence: true
  validates :stream_start,	presence: true
  validates :stream_end,		presence: true

  validate  :valid_time_slot

  validates :stream_start, :stream_end, :overlap => { :scope => [:user_id, :stream_day], :load_overlapped => true }

  belongs_to :user, -> { where(streamer: true) }

  default_scope -> { order(stream_day: :asc, stream_start: :asc, stream_end: :asc) }

  before_save :parse_start_and_stream_end

  private
  	def valid_time_slot
	  	if stream_start == nil
	  		errors.add(:stream_start, "Please Enter A Start Time (ﾉಠ_ಠ)ﾉ 彡 ┻━┻")
	  	elsif stream_end == nil
	  		errors.add(:stream_end, "Please Enter A End Time (ﾉಠ_ಠ)ﾉ 彡 ┻━┻")
  		else
	  		if !stream_end.strftime("%H").eql?("00") && stream_end <= stream_start
	  			errors.add(:stream_end, "Streams Can't Time Travel (づಠ╭╮ಠ)づ Please Try Again")
	  		end
	  	end
  	end

    def parse_start_and_stream_end
      tzone = User.find_by(id: user_id).time_zone

      t = stream_start.in_time_zone(tzone).utc_offset
      offset = (t / 3600).round
      offset = offset.to_s + ":00"

      self.stream_start = DateTime.new(stream_day.year, stream_day.month, stream_day.day, stream_start.hour, stream_start.min, stream_start.sec, offset)
      if stream_end.strftime("%H").eql?("00")
        self.stream_end = DateTime.new(stream_day.year, stream_day.month, stream_day.day + 1, stream_end.hour, stream_end.min, stream_end.sec, offset)
      else
        self.stream_end = DateTime.new(stream_day.year, stream_day.month, stream_day.day, stream_end.hour, stream_end.min, stream_end.sec, offset)
      end
    end
end