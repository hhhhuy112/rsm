$(document).ready(function(){
  $('input#search').keyup(function (){
    value_checked = get_value_checked();
    $.get($('#verified_search').attr('action'), $('#verified_search').serialize(), null, 'script');
    return false;
  });
});
$(document).ready(function() {
  $('.js-example-basic-multiple').select2();
});

$(document).ready(function() {
  $('.results :checkbox').click(function() {
    var values = $('#checked_values').val();
    if($(this).is(':checked')) {
      if(values === ''){
        values += $(this).val();
      }else{
        values +=(',' + $(this).val());
      }
    }else{
      values = remove_checked(values, $(this).val());
    }

    $('#checked_values').val(values);
  });
});

$(document).ready(function() {
  $('.load-page').on('click',function(){
    $('#img-loading').show();
    $('.config').css('opacity', 0.8);
  });
});

function remove_checked(values, member_id){
  var result = values.split(',').filter(function(elem){
      return elem !== member_id;
  });
  return result;
}


function get_value_checked(){
  var values = [];
  $('.results :checked').each(function() {
    values.push($(this).val());
  });
  return values;
}
