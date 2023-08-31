module SearchesHelper
  def search_users_results
    if params.dig(:search_word).present? && params.dig(:search_word).length > 0
      User.where('name LIKE ?', "%#{params.dig(:search_word)}%").order(name: :asc).all
    else
      []
    end
  end
end
