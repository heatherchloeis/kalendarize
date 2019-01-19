module CalendarHelper
	def block_position(o)
		if o.instance_of?(Stream)
			"top: #{(((o.stream_start - o.stream_start.midnight) / 3600 - 8) * 50) + 25}px;"
		elsif o.instance_of?(Event)
			if o.event_start.in_time_zone(current_user.time_zone).strftime("%d").eql?(o.event_end.in_time_zone(current_user.time_zone).strftime("%d"))
				"top: #{(((o.event_start - o.event_start.midnight) / 3600 - 8) * 50) + 25}px;"
			else
				"top: #{(((o.event_start - o.event_end.midnight) / 3600 - 8) * 50) + 25}px;"
			end
		end			
	end

	def block_height(o)
		if o.instance_of?(Stream)
			"height: #{(o.stream_end - o.stream_start) * 50 / 3600}px;"
		elsif o.instance_of?(Event)
			if o.event_start.in_time_zone(current_user.time_zone).strftime("%d").eql?(o.event_end.in_time_zone(current_user.time_zone).strftime("%d"))
				"height: #{(o.event_end.in_time_zone(current_user.time_zone) - o.event_start.in_time_zone(current_user.time_zone)) * 50 / 3600}px;"
			else
				"height: #{(o.event_end.strftime("%H:%M:%S").in_time_zone(current_user.time_zone) - o.event_start.strftime("%H:%M:%S").in_time_zone(current_user.time_zone)) * 50 / 3600}px;"
			end
		end
	end

	def block_color
		r = rand(255).to_s(16)
		g = rand(255).to_s(16)
		b = rand(255).to_s(16)
		r, g, b = [r, g, b].map { |n| if n.size == 1 then '0' + n else n end }
		color = r + g + b
		"background-color: ##{color};"
	end
end