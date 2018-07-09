$(document).ready(function() {
  $('.datepick').datepicker( {
    format: I18n.t("datepicker.format"),
    startView: 'months'
  });

  $('.date_apply').datepicker({
    startView: 'months',
    dateFormat: I18n.t("datepicker.format"),
    minDate: 0
  });

  $('.datepick-birthday').datepicker( {
    dateFormat: I18n.t('datepicker.format'),
    startView: 'months',
    endDate: '+0d'
  });

  $('#datepicker').datepicker({
    dateFormat: I18n.t('datepicker.format'),
    startView: 'months',
    minDate: 0
  });
});
