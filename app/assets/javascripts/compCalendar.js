var CompCalendar = function() {
  var calendarEvents  = $('.calendar-events');
  var initEvents = function() {
    $('.calendar-events').find('li').each(function() {
      var eventObject = {is_new: true, title: $.trim($(this).text()), color: $(this).css('background-color')};
      $(this).data('eventObject', eventObject);
      $(this).draggable({ zIndex: 999, revert: true, revertDuration: 0 });
    });
  };

  return {
    init: function() {
      initEvents();
      var startValue = $('.apply-appointment-start_time').val();
      var endValue = $('.apply-appointment-end_time').val();
      var startDate = getStartDate(startValue);
      var endDate = getEndDate(endValue, startDate);

      eventsValues = $('#apply-appointments').data('events');
      eventName = $('#apply-appointments').data('name');
      var events = [];
      events = Object.keys(eventsValues).map(function(key){
        var event = eventsValues[key];
        var start_time = event[0]['start_time'];
        var end_time = event[0]['end_time'];
        return {
          title: key.toString(),
          start: moment(new Date(start_time)),
          end: moment(new Date(end_time)),
          allDay: false,
          color: 'black',
          editable: false
        };
      });

      if(startValue !== null && startValue !== ''){
        event = {
          is_new: true,
          title: eventName,
          start: moment(new Date(startDate)),
          end: moment(new Date(endDate)),
          allDay: false,
          color: 'rgb(52, 152, 219);',
        };
        events.push(event);
      }

      var eventInput = $('#add-event');
      var eventInputVal = '';

      $('#add-event-btn').on('click', function(){
        eventInputVal = eventInput.prop('value');
        if( eventInputVal ){
          $('.calendar-events').append('<li class="animation-slideDown">' + eventInputVal + '</li>');
          eventInput.prop('value', '');
          initEvents();
        }
        return false;
      });

      $('#calendar').fullCalendar({
        header: {
          left: 'prev,next',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
        },
        timezone: false,
        axisFormat: 'HH:mm',
        timeFormat: {
            agenda: 'HH:mm'
        },
        eventDrop: function(event, delta, revertFunc) {
          var day = event.start.clone();
          day.startOf('day');
          if (day.isBefore(moment().startOf('day'))) {
            revertFunc()
          }
        },
        firstDay: 1,
        editable: true,
        droppable: true,
        drop: function(date, allDay) {
          var originalEventObject = $(this).data('eventObject');
          var copiedEventObject = $.extend({}, originalEventObject);
          startTime = date._d;
          endTime = getEndDay(date._d);

          copiedEventObject.start = date._d;
          copiedEventObject.end = getEndDay(date._d);

          // check validate
          if (date.isBefore(moment().startOf("day"))) {
            alertify.error(I18n.t('fullcalendar.error_mgs'));
          } else {
            $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
            $(this).remove();

            setValueDate('.apply-appointment-start_time', moment(startTime).format(I18n.t('time.formats.datetimepicker_full_calendar')));
            setValueDate('.apply-appointment-end_time', moment(endTime).format(I18n.t('time.formats.datetimepicker_full_calendar')));
          }
        },

        events: events,
        eventRender: function( event, element, view ) {
          if(event.changing){
            if(event.start !== null) {
              var startTime = moment(event.start).format(I18n.t('time.formats.datetimepicker_full_calendar'));
              setValueDate ('.apply-appointment-start_time', startTime);
            }

            if(event.end !== null) {
              var endTime = moment(event.end).format(I18n.t('time.formats.datetimepicker_full_calendar'));
              setValueDate ('.apply-appointment-end_time', endTime);
            }
          }
        },

        eventResizeStart: function(event, jsEvent, ui, view ){
          event.changing = true;
        },

        eventResizeEnd: function(event, jsEvent, ui, view ){
          event.changing = false;
        },

        eventDragStart: function(event, jsEvent, ui, view ){
          event.changing = true;

        },

        eventDragEnd: function(event, jsEvent, ui, view ){
          event.changing = false;

        },

        eventResize: function(event, delta, revertFunc) {
          var endTime = event.end.format(I18n.t('time.formats.datetimepicker_full_calendar'));
          setValueDate ('.apply-appointment-end_time', endTime);
        }
      });

      $('.apply-appointment-start_time').datetimepicker({
        format: I18n.t('time.formats.datetimepicker'),
        minDate: new Date(),
        minTime: '7:45',
        maxTime: '17:00',
        step: 15,
        onClose: function() {
          after_close_datetimepicker_start();
        }
      });

      $('.apply-appointment-end_time').datetimepicker({
        format: I18n.t('time.formats.datetimepicker'),
        minTime: '7:45',
        maxTime: '17:00',
        step: 15,
        minDate: new Date(),
        onClose: function() {
          after_close_datetimepicker_end();
        }
      });
    }
  };
}();

function setValueDate (element, time){
  $(element).val(time);
}

function getStartDate(date){
  if(date !== null && date !== ''){
    return convertStringToTime(date);
  }else{
    return new Date();
  }
}

function getEndDate(date, startDate){
  if(date !== null && date !== ''){
    return convertStringToTime(date);
  }else{
    return getEndDay(startDate)
  }
}

function getEndDay(startTime){
  var d = startTime.getDate();
  var m = startTime.getMonth();
  var y = startTime.getFullYear();
  return new Date(y, m, d, 16, 45);
}

function getStartDay(endTime){
  var d = endTime.getDate();
  var m = endTime.getMonth();
  var y = endTime.getFullYear();
  return new Date(y, m, d, 7, 45);
}

function convertStringToTime(stringTime){
  if(stringTime !== null){
    return moment(stringTime, I18n.t('time.formats.datetimepicker_full_calendar')).toDate()
  }
}

function convertTimetoString(time) {
  if (time !== null) {
    var d = time.getDate();
    var m = time.getMonth() + 1;
    var y = time.getFullYear();
    var h = time.getHours();
    var min = time.getMinutes();
    return h + ':' + min + ' ' + d + '/' + m + '/' + y;
  }
}

function after_close_datetimepicker_start() {
  var start_time = moment($('#apply_status_appointment_attributes_start_time').val(), I18n.t('time.formats.datetimepicker_full_calendar')).toDate();
  if (start_time !== null) {
    if ($('#apply_status_appointment_attributes_end_time').val() === '') {
      var end_time = getEndDay(start_time);
      $('#apply_status_appointment_attributes_end_time').val(convertTimetoString(end_time));
      handling_event(start_time, end_time);
    } else {
      var end_time = moment($('#apply_status_appointment_attributes_end_time').val(), I18n.t('time.formats.datetimepicker_full_calendar')).toDate();

      if (end_time < start_time) {
        alertify.error(I18n.t('clubs.model.date1'));
      }
      else {
        handling_event(start_time, end_time);
      }
    }
  }
}

function after_close_datetimepicker_end() {
  var end_time = moment($('#apply_status_appointment_attributes_end_time').val(), I18n.t('time.formats.datetimepicker_full_calendar')).toDate();

  if (end_time !== null) {
    if ($('#apply_status_appointment_attributes_start_time').val() === '') {
      var start_time = getStartDay(end_time);
      $('#apply_status_appointment_attributes_start_time').val(convertTimetoString(start_time));
      handling_event(start_time, end_time);
    } else {
      var start_time = moment($('#apply_status_appointment_attributes_start_time').val(), I18n.t('time.formats.datetimepicker_full_calendar')).toDate();
      if (end_time < start_time) {
        alertify.error(I18n.t("clubs.model.date1"));
      }
      else {
        handling_event(start_time, end_time);
      }
    }
  }
}

function handling_event(start_time, end_time) {
  var eventName = $('#apply-appointments').data('name');
  var events = $('#calendar').fullCalendar('clientEvents');
  var event = events.find(function (event) { return event.is_new === true;});
  if (event !== undefined) {
    event.start = start_time;
    event.end = end_time;
    $('#calendar').fullCalendar('updateEvent', event);
  } else {
    var myEvent = {
      is_new: true,
      title: eventName,
      start: start_time,
      end: end_time,
      allDay: false,
      color: 'rgb(52, 152, 219);'
    };
    $('#calendar').fullCalendar('renderEvent', myEvent);
    $('.calendar-events').hide();
  }
}
