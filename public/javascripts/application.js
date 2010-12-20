var doConvertXaml = function(){
  $.ajax({
    url: convert_path,
    type: 'POST',
    success: function(data, status, request){
      window.location.reload();
    }
  });
};

$(document).ready(function(){
  $('#convert_to_haml button').attr('disabled', null).click(function() {
    doConvertXaml();
    return false;
  });
});
