var CompCalendar = function() {
  var calendarEvents  = $('.calendar-events');
  var initEvents = function() {
    $('.calendar-events').find('li').each(function() {
      var eventObject = { title: $.trim($(this).text()), color: $(this).css('background-color') };
      $(this).data('eventObject', eventObject);
      $(this).draggable({ zIndex: 999, revert: true, revertDuration: 0 });
    });
  };

  return {
    init: function() {
      initEvents();
      var startValue = $('.apply-appointment-start-time').val();
      var endValue = $('.apply-appointment-end-time').val();
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

            setValueDate('.apply-appointment-start-time', moment(startTime).format(I18n.t('time.formats.format_datetime_picker')));
            setValueDate('.apply-appointment-end-time', moment(endTime).format(I18n.t('time.formats.format_datetime_picker')));
          }
        },

        events: events,
        eventRender: function( event, element, view ) {
          if(event.changing){
            if(event.start !== null) {
              var startTime = event.start.format(I18n.t('time.formats.format_datetime_picker'));
              setValueDate ('.apply-appointment-start-time', startTime);
            }

            if(event.end !== null) {
              var endTime = event.end.format(I18n.t('time.formats.format_datetime_picker'));
              setValueDate ('.apply-appointment-end-time', endTime);
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
          var endTime = event.end.format(I18n.t('time.formats.format_datetime_picker'));
          setValueDate ('.apply-appointment-end-time', endTime);
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

function convertStringToTime(stringTime){
  if(stringTime !== null){
    return Date.parse(stringTime)
  }
}
