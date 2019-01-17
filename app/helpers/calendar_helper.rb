module CalendarHelper
	def stream_block_position(s)
		"top: #{(((s.stream_start - s.stream_start.midnight) / 3600 - 8) * 50) + 25}px;"
	end

	def stream_block_height(s)
		"height: #{(s.stream_end - s.stream_start) * 50 / 3600}px;"
	end

	def stream_block_color
		r = rand(255).to_s(16)
		g = rand(255).to_s(16)
		b = rand(255).to_s(16)
		r, g, b = [r, g, b].map { |n| if n.size == 1 then '0' + n else n end }
		color = r + g + b
		"background-color: ##{color};"
	end
end