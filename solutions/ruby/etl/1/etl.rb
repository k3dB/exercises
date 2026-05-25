class ETL
  def self.transform(old)
    old.each_with_object({}) do |(key, value), new|
      value.each { |v| new[v.downcase] = key }
    end
  end
end
