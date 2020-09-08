class CommentsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.create(comment_params)
    redirect_to product_path(@product)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(profile_id: current_user.profile.id)
  end
end