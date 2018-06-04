module ToursHelper

  def group_cards_tours(group)
    html = ''

    group.each_with_index do |tour, index|
      css_class = index < 2 ? 'col-md-6' : 'col-md-4'

      html << content_tag(:div, class: css_class) do
        render 'shared/card', tour: tour
      end
    end

    html.html_safe
  end
end
