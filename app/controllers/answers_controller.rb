class AnswersController < ApplicationController

  def create
    @comment = Comment.find(params[:comment_id])
    @product = @comment.product
    @answers = @comment.answers.create(params.require(:answer).permit(:body))
    redirect_to product_path(@product)
  end
  
end