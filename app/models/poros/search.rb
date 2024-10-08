class Poros::Search
  def self.call(target_class: nil, company_id: nil, column: nil, value: nil)
    comparison_operator, value = format_query_params(column, value)

    target_class.where("company_id = ? AND #{column} #{comparison_operator} ?", company_id, value)
  end

  def self.format_query_params(column, value)
    return [' = ', value.to_f] if %w[stock price].include?(column)

    [' ILIKE ', "%#{value}%"]
  end
end
