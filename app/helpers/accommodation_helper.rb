module AccommodationHelper
  def published_badge(accommodation)
    if accommodation.published?
      content_tag(:span, '公開', class: 'badge bg-success')
    else
      content_tag(:span, '非公開', class: 'badge bg-warning text-dark')
    end
  end
end