class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.where(company: current_user.company)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new 
  end

  def create
    @product = Product.new(product_params)
    @product.company_id = current_user.company_id
    @product.profile_id = current_user.id
    @product.save!
    redirect_to @product
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category)
  end

end