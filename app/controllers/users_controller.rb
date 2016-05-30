class UsersController < ApplicationController
  def show
  	@user = User.friendly.find(params[:id])
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: 15_00
    }
  end
end
