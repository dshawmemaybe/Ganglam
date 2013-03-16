// sets active for sidebar

$(function() {
    $('.settingsbut.home').tooltip();
$('.settingsbut.cal').tooltip();
$(".accordion-heading").click(function(){
    if ($(this).hasClass("active")){$(this).removeClass("active")}
      else {
        $(".accordion-heading").removeClass("active");
    $(this).addClass("active");
  }
  });

$('.settingspop').popover({ html : true});
$('.settingspop').tooltip({ title : "Settings", placement : "right"});

$('.accordion-heading.hq').tooltip({title : "Specify HQ", placement : "left", container : "#maincontainer"});
$('.accordion-heading.groups').tooltip({title : "Select a group", placement : "left", container : "#maincontainer"});
$('.accordion-heading.users').tooltip({title : "Choose users ", placement : "left", container : "#maincontainer"});
$('.accordion-heading.display').tooltip({title : "Change display", placement : "left", container : "#maincontainer"});
$('.accordion-heading.function').tooltip({title : "Perform functions", placement : "left", container : "#maincontainer"});
});