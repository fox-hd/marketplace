class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]


  def show
    @product = Product.find(params[:product_id])
    @order = @product.order
  end

  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params)
    @order.save
    @product.waiting!
    redirect_to @product, notice: 'Compra efetuada com sucesso, aguarde confirmação do vendedor'
  end

  private

  def order_params
    params.require(:order).permit(:body).merge(profile_id: current_user.profile.id, product_id: @product.id)
  end
end