class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  http_basic_authenticate_with name: "HHH",password: "WWE",except: [:create]

  def index
    @article = Article.find(params[:article_id])
    @article.comments=@article.comments
    respond_to do |format|
      format.json { render json: {status: 'SUCCESS',  comments: @article.comments},status: :ok }
      format.html 
    end
  end
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.json { render json: {status: 'SUCCESS',message: 'Comment added successfully'  },status: :ok}
    end  
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end 

  private 
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
