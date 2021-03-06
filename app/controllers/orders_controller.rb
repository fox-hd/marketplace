class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index,:show, :new, :create]

  def index
    @orders = Order.where(profile_id: current_user.profile)
  end

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
    @order.waiting!
    @product.disable!
    redirect_to @product, notice: 'Compra efetuada com sucesso, aguarde confirmação do vendedor'
  end

  def accept
    @order = Order.find(params[:id])
    @order.accept!
    @order.product.sold!
    redirect_to status_product_path(@order.product, @order), notice: 'Venda finalizada'
  end

  def decline
    @order = Order.find(params[:id])
    @order.decline!
    @order.product.enable!
    redirect_to status_product_path(@order.product, @order), notice: 'Venda recusada'
  end
  private

  def order_params
    params.require(:order).permit(:body).merge(profile_id: current_user.profile.id, product_id: @product.id)
  end
end