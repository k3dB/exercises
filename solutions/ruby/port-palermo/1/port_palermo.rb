module Port
  IDENTIFIER = :PALE
  PORT_A_CARGO = ["OIL", "GAS"].freeze

  def self.get_identifier(city)
    city[0..3].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    return :A if PORT_A_CARGO.any? { |c| ship_identifier.start_with?(c) }
    :B
  end
end
