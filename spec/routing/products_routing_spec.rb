require 'rails_helper'

RSpec.describe ProductsController, type: :routing do
  it { expect(get:    "/products").to   route_to("products#index") }
  it { expect(get:    "/products/1").to route_to("products#show", id: "1") }
  it { expect(post:   "/products").to   route_to("products#create") }
  it { expect(put:    "/products/1").to route_to("products#update", id: "1") }
  it { expect(delete: "/products/1").to route_to("products#destroy", id: "1") }
end
