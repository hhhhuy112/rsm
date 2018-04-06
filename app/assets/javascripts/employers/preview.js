$(document).ready(function(){
  $('#btn-preview').click(function(){
    $('.job-form').hide(700);
    $('#preview').show(700);
    $(this).hide(700);
    $('#btn-back').show(700);

    job = getDataForm('form-job');

    $('.job-title').text(job.name);
    $('.branch-name').text(('(' + I18n.t('branch_in') + job.branch + ')').toUpperCase());
    $('.salary').text(convertSalary(job.min_salary, job.max_salary, job.currency));
    $('#job-category').text(job.category);
    $('#target-job').text(job.target);
    $('#position-job').text(job.position);
    $('#level-job').text(job.level);
    $('#skill-job').append($.parseHTML(job.skill));
    $('#language-job').text(job.language);
    $('#position-types').text($("select[name='job[position_types]'] option:selected").text());
    if (job.survey_type !== null) {
      $('#survey-job').text('(' + getSurveyType(job.survey_type) + ')');
    }

    getBenefits();
    getQuestions(job.question_ids);
    removeChild('#job-expried');
    if (job.end_time !== '') {
      $('#job-expried').text(I18n.t('expire_at') + job.end_time);
    }
    removeChild('#description-job');
    if (job.description !== '') {
      $('#description-job').append($.parseHTML(job.description));
    } else {
      $('#description-job').append('<small class="text-muted">' + I18n.t('none_content') + '</small>');
    }

    removeChild('#requirement-job');
    if (job.request !== '') {
      $('#requirement-job').append($.parseHTML(job.request));
    } else {
      $('#requirement-job').append('<small class="text-muted">' + I18n.t('none_content') + '</small>');
    }
  });

  $('#btn-back').click(function(){
    $('#preview').hide(700);
    $('.job-form').show(700);
    $(this).hide(700);
    $('#btn-preview').show(700);
  });

  $(document).on('change', '#job_name, #job_currency_id, #job_min_salary, #job_target, #job_branch_id, #job_category_id', function() {
    check_validate_form('form-job');
  });

  CKEDITOR.instances['job_description'].on('change', function() {
    check_validate_form('form-job');
  });

  CKEDITOR.instances['content-benefits'].on('change', function() {
    check_validate_form('form-job');
  });

  function getDataForm (element) {
    var status_job = document.getElementById(element);
    var data_job = new FormData(status_job);
    var job = {
      name: data_job.get('job[name]'),
      min_salary: data_job.get('job[min_salary]'),
      max_salary: data_job.get('job[max_salary]'),
      target: data_job.get('job[target]'),
      language: data_job.get('job[language]'),
      position: data_job.get('job[position]'),
      level: data_job.get('job[level]'),
      skill: CKEDITOR.instances['job_skill'].getData(),
      description: CKEDITOR.instances['job_description'].getData(),
      request: CKEDITOR.instances['job_content'].getData(),
      survey_type: data_job.get('job[survey_type]'),
      question_ids: data_job.get('choosen_ids'),
      end_time: data_job.get('job[end_time]'),
      benefit: CKEDITOR.instances['content-benefits'].getData()
    }

    if ($('#job_branch_id').val() !== '') {
      job.branch = $('#job_branch_id option[value=' + $('#job_branch_id').val() + ']').text();
    }

    if ($('#job_category_id').val() !== '') {
      job.category = $('#job_category_id option[value=' + $('#job_category_id').val() + ']').text();
    }

    if ($('#job_currency_id').val() !== '') {
      job.currency = $('#job_currency_id option[value=' + $('#job_currency_id').val() + ']').text();
    }
    return job
  }

  function convertSalary(min_salary, max_salary, currency) {
    if (max_salary === '') {
      return I18n.t('up_to') + min_salary + currency
    } else {
      return min_salary + currency + '-' + max_salary + currency
    }
  };

  function getSurveyType(id) {
    if (id !== '') {
      return $('label[for=radio' + id + ']').text();
    } else {
      return I18n.t('none_content');
    }
  }

  function getQuestions(ids) {
    if (ids !== '') {
      ids = ids.split(',');
      removeChild('.summary-question');
      $.each(ids, function(id, value) {
        if (value !== '') {
          name = $('#question-content-' + value).text();
          $('.summary-question').append('<li>' + name + '</li>');
        }
      });
    }

    $.each($('.question-survey'), function(id) {
      id = $('.question-survey').eq(id).attr('id');
      name = $('#' + id).val();
      $('.summary-question').append('<li>' + name + '</li>');
    });
  }

  function getBenefits() {
    $('#reward-benefit').html(CKEDITOR.instances['content-benefits'].getData());
  }

  function removeChild(element) {
    $(element).children().remove();
  }

  function check_value(name, description, min_salary, target, branch_id, category_id, currency, benefit) {
    if (name === '' || description === '' || min_salary === '' || target === '' || branch_id === undefined || category_id === undefined || currency === '' || benefit === '') {
      $('#btn-preview').attr('disabled', true);
    } else {
      $('#btn-preview').attr('disabled', false);
    }
  }

  function check_validate_form(element) {
    job = getDataForm(element);
    check_value(job.name, job.description, job.min_salary, job.target, job.branch, job.category, job.currency, job.benefit);
  }

  $('#form-job').validate({
    errorClass: 'help-block animation-slideDown',
    errorElement: 'div',
    errorPlacement: function(error, e) {
      e.parents('.form-group').append(error);
    },
    highlight: function(e) {
      $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
      $(e).closest('.help-block').remove();
    },
    success: function(e) {
      if (e.closest('.form-group').find('.help-block').length === 2) {
        e.closest('.help-block').remove();
      } else {
        e.closest('.form-group').removeClass('has-success has-error');
        e.closest('.help-block').remove();
      }
    },
    ignore: [],
    debug: false,
    rules: {
      'job[name]': {
        required: true
      },
      'job[min_salary]': {
        required: true,
        number: true
      },
      'job[target]': {
        required: true,
        number: true
      },
      'job[branch_id]': {
        required: true
      },
      'job[category_id]': {
        required: true
      },
      'job[currency_id]': {
        required: true
      },
      'job[description]': {
        required: function(textarea)
        {
          CKEDITOR.instances[textarea.id].updateElement();
          var editorcontent = textarea.value.replace(/<[^>]*>/gi, '');
          if(editorcontent.length === 0) {
            $('#manageJob').animate({scrollTop: $('textarea[name="job[description]"]').position().top}, 'slow');
            return true;
          }
        }
      },
      'job[reward_benefits_attributes][0][content]': {
        required: function(textarea)
        {
          CKEDITOR.instances[textarea.id].updateElement();
          var editorcontent = textarea.value.replace(/<[^>]*>/gi, '');
          if (editorcontent.length === 0) {
            $('#manageJob').animate({scrollTop: $('.reward_benefits').position().top}, 'slow');
            return true;
          }
        }
      }
    }
  });
});
