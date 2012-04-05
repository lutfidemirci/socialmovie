$("document").ready(function(){
	$("a.watch-action").click(function(){
		var element = $(this);
		if (element.hasClass("passive")){
			alert("passive");
			return false;
		} else {
			var mid = element.attr('mid');
			element.removeClass("btn-orangey").addClass("passive").html("Posting");
			$.post('/movie/listwatch/'+ mid, function(data) {
			  if (data.status == "true"){
					element.addClass("btn-success").html("Posted");
				} else {
					console.log(data.error);
					element.addClass("btn-danger").html("Error");
				}
				setTimeout(function() {
					element.removeClass("passive btn-success btn-danger").addClass("btn-orangey").html("List as Watched");
				},2000);
			});
			return false;
		}
	});
	
	$("a.wantwatch-action").click(function(){
		var element = $(this);
		if (element.hasClass("passive")){
			alert("passive");
			return false;
		} else {
			var mid = element.attr('mid');
			element.removeClass("btn-bluey").addClass("passive").html("Posting");
			$.post('/movie/wantwatch/'+ mid, function(data) {
			  if (data.status == "true"){
					element.addClass("btn-success").html("Posted");
				} else {
					console.log(data.error);
					element.addClass("btn-danger").html("Error");
				}
				setTimeout(function() {
					element.removeClass("passive btn-success btn-danger").addClass("btn-bluey").html("Want to Watch");
				}, 2000);
			});
			return false;
		}
	});
	
})