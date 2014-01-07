module DeviseHelper


  def devise_error_messages!
      return "" if resource.errors.empty?

      return flash[:notice].to_a.concat resource.errors.full_messages
  end
  
end