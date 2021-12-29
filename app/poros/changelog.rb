class Changelog
  attr_reader :payer, :points

  def initialize(payer, points)
    @payer = payer
    @points = points
  end
end 
