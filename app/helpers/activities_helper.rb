module ActivitiesHelper

  DAYS_OF_WEEK = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']

  def day_checkboxes(form)
    ''.tap do |result|
      DAYS_OF_WEEK.each do |day|
        result << form.check_box('days', {multiple: true, class: 'form-check-input'}, day.capitalize, '')
        result << form.label(:"days_#{day}", day.capitalize, class: 'form-check-label mr-3')
      end
    end.html_safe
  end

end
