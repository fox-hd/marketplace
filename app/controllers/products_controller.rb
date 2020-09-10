class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :upgrade, :my_products]

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
    @product.profile_id = current_user.profile.id
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

  def my_products
    @profile = Profile.find_by(user_id: current_user.id)
    @products_disable = Product.where(profile: @profile).where(status: :disable)
    @products_enable = Product.where(profile: @profile).where(status: :enable)
    @products_sold = Product.where(profile: @profile).where(status: :sold)
    @products_canceled = Product.where(profile: @profile).where(status: :canceled)
  end


  def enable
    @product = Product.find(params[:id])
    @product.enable!
    redirect_to my_products_path, notice: 'Anuncio reativado'
  end

  def disable
    @product = Product.find(params[:id])
    @product.canceled!
    redirect_to my_products_path, notice: 'Anuncio desativado'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category)
  end

end