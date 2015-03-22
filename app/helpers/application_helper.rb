module ApplicationHelper

    # Returns the full title on a per-page basis.
    def full_title(page_title)
        base_title = "Atlântico Português"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end

    def build_flash(key, value)
      type =  case key
              when 'error'
                "danger"
              when 'notice'
                "success"
              else
                key
              end
      content_tag(:div, value, class: "alert alert-#{type}")
    end
end
