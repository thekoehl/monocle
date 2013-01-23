module ApplicationHelper
	def error_messages(obj)
    	if obj.errors.any?
      		msg =  '<div class="alert danger">'
      		msg << '	' + obj.errors.full_messages.map { |msg| "<p><strong>Error!</strong> #{sanitize(msg)}</p>" }.join + ''
      		msg << '</div>'
      		raw(msg)
      	end
  	end
end
