class ProductDecorator < ApplicationDecorator
  delegate_all

  def image
    if object.cover_product.attached?
      object.cover_product
    else
      "https://via.placeholder.com/150"
    end
  end
end
