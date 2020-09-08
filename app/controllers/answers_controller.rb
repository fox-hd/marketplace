class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.find(params[:comment_id])
    @product = @comment.product
    @answers = @comment.answers.create(params.require(:answer).permit(:body))
    redirect_to product_path(@product)
  end
  
end