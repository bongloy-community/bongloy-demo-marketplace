require "rails_helper"

RSpec.describe Dashboard::ProductsController, type: :routing do
  it { expect(get:    "/dashboard/products").to   route_to("dashboard/products#index") }
  it { expect(get:    "/dashboard/products/1").to route_to("dashboard/products#show", id: "1") }
  it { expect(post:   "/dashboard/products").to   route_to("dashboard/products#create") }
  it { expect(put:    "/dashboard/products/1").to route_to("dashboard/products#update", id: "1") }
  it { expect(delete: "/dashboard/products/1").to route_to("dashboard/products#destroy", id: "1") }
end
