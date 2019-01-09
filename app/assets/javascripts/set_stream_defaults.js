(function() {
	$("#stream_day").on("change", function() {
		console.log($("#stream_day").val())
		if ($("#stream_day").val() = "2019-01-06") {
			$("#stream_start_time").min = "2019-01-06 00:00:00";
			$("#stream_end_time").max = "2019-01-06 23:59:59";
		}
	});
})();