class AddsToShoppingCart

  attr_accessor :user, :product

  def initialize(user:, product:)
    @user = user
    @product = product
    @success = false
  end

  def run
    Product.transaction do
      tickets = performance.unsold_tickets(count)
      return if tickets.size != count
      tickets.each { |ticket| ticket.place_in_cart_for(user) }
      self.success = tickets.all?(&:valid?)
      success
    end
  end
end

