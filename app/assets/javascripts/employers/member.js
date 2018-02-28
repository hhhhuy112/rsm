$(document).ready(function(){
  $('.add-member').submit(function(e) {
    e.preventDefault();
    var url = $(this).attr('action');
    var data_array = $(this).serializeArray();
    data_array = get_role_checked(data_array);
    var data = JSON.parse(JSON.stringify(data_array));
    $.post(url, data)
  });
});

function get_role_checked(data_array) {
  data_array.push({name: 'member[user_roles][]', value: ''});
  $('.checked-member:checked').each(function() {
    role = $(this).closest('tr').find($('.member-role')).val();
    data_array.push({name: 'member[user_roles][]', value: role});
  });
  return data_array
}
