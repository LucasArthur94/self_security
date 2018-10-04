module ApplicationHelper
  def highlight_page_on_navigation(current_path)
    if current_page?(current_path)
      "nav-link active"
    else
      "nav-link"
    end
  end

  def translate_relations_name(objects)
    objects&.klass&.model_name&.human(count: objects.length)
  end

  def translate_model_name(object)
    object&.model_name&.human
  end
end
