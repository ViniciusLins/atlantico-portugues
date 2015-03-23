module DocumentsHelper
  def limit_string(big_string)
    if big_string.size > 255
      big_string[1..255] + '...'
    else
      big_string
    end
  end

  def build_results_text(total)
     results = I18n.t('documents.search.result').pluralize(total) 
     founds = I18n.t('documents.search.found').pluralize(total) 
     "#{total} #{results} #{founds}"
  end
end
