$(document).ready(function(){
  $('#all-email').on('click', function(){
    $('#email-sent-table tbody tr').removeClass('display-none');
  });

  $('#sending-email').on('click', function(){
    $('#email-sent-table tbody tr').addClass('display-none');
    $('#email-sent-table tbody .item-sending').removeClass('display-none');
  });

  $('#success-email').on('click', function(){
    $('#email-sent-table tbody tr').addClass('display-none');
    $('#email-sent-table tbody .item-success').removeClass('display-none');
  });

  $('#failure-email').on('click', function(){
    $('#email-sent-table tbody tr').addClass('display-none');
    $('#email-sent-table tbody .item-failure').removeClass('display-none');
  });
});
