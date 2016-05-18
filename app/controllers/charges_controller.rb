class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
    charge = Stripe::Charge.create(
      customer: customer.id, 
      amount: 15_00, 
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    if charge.paid == true
      current_user.premium!
      current_user.charges.create(
        stripe_charge_id: charge.id,
        amount: charge.amount    
      )
      current_user.update(stripe_id: customer.id)
      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
      redirect_to user_path(current_user) 
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
    last_charge = current_user.charges.where(refunded: false).first
    refund = Stripe::Refund.create(
      charge: last_charge.stripe_charge_id
    )

    if refund.status == 'succeeded'
      current_user.standard!
      last_charge.update(refunded = true)
      current_user.wikis.where(private: true).each do |wiki|
        wiki.update(private: false)
      end
      flash[:notice] = "You are now a lowly standard user"
    else
      flash[:alert] = 'Downgrade failed'
    end

    redirect_to user_path(current_user) 
  end
end
