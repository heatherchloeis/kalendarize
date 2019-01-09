if Rails.env.test?
	Carrierwave.configure do |f|
		config.enable_processing = false
	end
end