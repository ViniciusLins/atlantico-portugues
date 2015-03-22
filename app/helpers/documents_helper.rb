module DocumentsHelper
  def limit_string(big_string)
    if big_string.size > 255
      big_string[1..255] + '...'
    else
      big_string
    end
  end
end
