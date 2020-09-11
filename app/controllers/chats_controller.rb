class ChatsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @order = Order.find(params[:order_id])
    @chat = @order.chats.create(params.require(:chat).permit(:body).merge(profile_id: current_user.profile.id))
    redirect_to product_order_path(@order.product, @order), notice: 'O vendedor vai responder em breve'

  end

end