module ApplicationHelper
  def error_messages(object, conf = {})
    if conf[:skip_prefix]
      errors = object.errors.reject {|field, m| field =~ /^#{conf[:skip_prefix]}/}
    else
      errors = object.errors
    end
    return if errors.empty?
    out = %Q{<div class="validation_errors">}.html_safe
    out += %Q{<h2>#{t('common.object')} #{t('common.could_not_be_saved')}</h2>}.html_safe unless conf[:skip_header]
    out += "<ul>".html_safe
    errors.each do |field, messages|
      next if conf[:skip_prefix] && field =~ /^#{conf[:skip_prefix]}/
      [messages].flatten.each do |message|
        field_name = field.to_s =~ /base/ ? '' : "#{t("activerecord.attributes.#{model_class_name(object)}.#{field}")} "
        out += %Q{<li>#{field_name}#{message}</li>}.html_safe
      end
    end
    out + '</ul></div>'.html_safe
  end

  def model_class_name(model)
    model_class = model.class
    until model_class.superclass == ActiveRecord::Base || model_class.superclass == Object
      model_class = model_class.superclass
    end
    model_class.name.underscore
  end

  def allowed?(action, record = nil)
    @policy.class.new(current_user, params, record).allowed?(action)
  end
end
