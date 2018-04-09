$(document).ready(function() {
  $(document).on('click', '.btn-see-more', function() {
    var status = $(this).attr('data-open');
    var id = $(this).attr('data-id');
    if (status === 'false') {
      $(this).text(I18n.t('close'));
      $(this).attr('data-open', true);
      $('#content-mail-' + id).show(500);
    } else {
      $(this).text(I18n.t('read_more'));
      $(this).attr('data-open', false);
      $('#content-mail-' + id).hide(500);
    }
  });
});
