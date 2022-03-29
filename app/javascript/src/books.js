$(document).on('turbolinks:load', function(){
  $(document).ready(function() {
    var showChar = 250;
    var ellipsesText = "...";
    var moreText = "Read more";
    var lessText = "Read less";

    $('#minus').click(function(e){
      var current_value = $('.input-count-book').val();
      if (current_value >= 2) {
        var new_value = Number(current_value) - 1;
        $('.input-count-book').val(new_value);
      }
    });
  
    $('#plus').click(function(e){
      var current_value = $('.input-count-book').val();
      if (current_value < 10) {
        var new_value = Number(current_value) + 1;
        $('.input-count-book').val(new_value);
      }
    });

    $('.textControl').each(function() {
      var content = $(this).html();
      if(content.length > showChar) {
          var c = content.substr(0, showChar);
          var h = content.substr(showChar, content.length - showChar);
          var html = c + '<span class="moreellipses">' + ellipsesText+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moreText + '</a></span>';
          $(this).html(html);
      }
    });

    $(".morelink").click(function(){
      if($(this).hasClass("less")) {
          $(this).removeClass("less");
          $(this).html(moreText);
      } else {
          $(this).addClass("less");
          $(this).html(lessText);
      }
      $(this).parent().prev().toggle();
      $(this).prev().toggle();
      return false;
    });
  });
})
