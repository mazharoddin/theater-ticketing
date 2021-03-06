require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:user) { create(:user) }
  let(:performance) {  create(:performance, event: create(:event)) }

  it "can move to waiting" do
    ticket = create(:ticket, status: "unsold", user: user, performance: performance)
    ticket.place_in_cart_for(user)

    expect(ticket.user).to eq(user)
    expect(ticket.status).to eq("waiting")
  end

  it "can move to purchased" do
    ticket = create(:ticket, status: "waiting", user: user, performance: performance)
    ticket.purchased!

    expect(ticket.user).to eq(user)
    expect(ticket.status).to eq("purchased")
  end
end
