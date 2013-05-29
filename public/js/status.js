$(document).ready(function() {
  var job_id = $('p#job_id').text();
  setInterval(function() {
    $.post('/status/' + job_id, function(status){
    
      $('#status').html(status);
      if (status === 'complete') {
        setTimeout(function(){
          window.location.href = "/";
        }, 1000);
      }

    });
  }, 1000);

});
