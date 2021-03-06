class ChangesStripeSubscriptionPlan

  attr_accessor :subscription, :user

  def initializer(subscription_id:, user:, new_plan_id:)
    @subscription_id = subscription_id
    @new_plan_id = new_plan_id
    @user = user
    @success = false
  end

  def new_plan
    @plan = Plan.find(new_plan_id)
  end

  def subscription
    @subscription ||= Subsciption.find(subscription_id)
  end

  def customer
    @customer ||= StripeCustomer.new(user)
  end

  def remote_subscription
    @remote_subscription ||=
      customer.subscriptions.retrieve(subscription.remote_id)
  end

  def user_is_subscribed?
    subscription_id && user.subscriptions.map(&:id).include?(subscription_id)
  end

  def run
    return unless user_is_subscribed?
    return if customer.nil? || remote_subscription.nil?
    remote_subscription.plan = new_plan.remote_id
    subscription.update(plan: new_plan)
    remote_subscription.save
  end
end
