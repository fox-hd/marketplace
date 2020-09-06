class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :upgrade]

  def index
    @products = Product.where(company: current_user.company)
    @profile = Profile.find_by(user_id: current_user.id)
    @products_profile = Product.where(profile: @profile)
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
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.save
      redirect_to @product
    else
      render :edit
    end
  end

  def search
    @products_company = Product.where(company: current_user.company)
    @products = @products_company.where('name || description || category LIKE ?', "%#{params[:q]}%")
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category)
  end

end