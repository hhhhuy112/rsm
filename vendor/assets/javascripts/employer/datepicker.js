$(document).ready(function() {
  $('#user_birthday').datepicker({
    format: 'yyyy/mm/dd'
  });
});
$(document).ready(function(){
  $('.datepick').datepicker( {
    format: 'dd-mm-yyyy',
    startView: 'months'
  });
});

$(document).ready(function(){
  function runningFormatter(value, row, index) {
    return index;
  };
});
