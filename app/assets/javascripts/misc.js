// sets active for sidebar

$(function() {
$(".accordion-heading").click(function(){
    if ($(this).hasClass("active")){$(this).removeClass("active")}
      else {
        $(".accordion-heading").removeClass("active");
    $(this).addClass("active");
  }
  });
});