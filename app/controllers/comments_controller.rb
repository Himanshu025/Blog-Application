class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index ,:show]
  def index
    @comments = Comment.all
    respond_to do |format|
      format.json { render json: { comments: @comments }, status: :ok }
      format.html
    end
  end

  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.json { render json: { comment: @comment }, status: :ok }
      format.html
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { message: "Not found" }, status: :not_found }
      format.html
    end
  end

  def create
    @comment = Comment.create(comment_params)
    @article = Article.find(@comment.article_id)
    if @comment.save
      respond_to do |format|
        format.json { render json: { comment: @comment }, status: :ok }
        format.html { redirect_to article_path(@article) }
      end
    else
      respond_to do |format|
        format.json { render json: { message: @comment.errors}, status: :unprocessable_entity }
        format.html { redirect_to articles_path }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update_attributes(params.require('comment').permit(:commenter, :body))
      respond_to do |format|
        format.json { render json: { comment: comment}, status: :ok }
        format.html { redirect_to comments_path }
      end
    else                    
      respond_to do |format|
        format.json { render json: { message: comment.errors}, status: :unprocessable_entity }
        format.html { redirect_to comments_path }
      end
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { message: "Not FOUND" }, status: :not_found }
      format.html
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.json { render json: {  message: "deleted"}, status: :ok }
      format.html { redirect_to comments_path}
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { comment: "Comment not found" }, status: :not_found }
      format.html { redirect_to article_path(@article) }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :article_id)
  end
end