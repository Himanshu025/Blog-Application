class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index]
  def index
    @article = Article.find(params[:article_id])
    @article.comments=@article.comments
    respond_to do |format|
      format.json { render json: {comments: @article.comments},status: :ok }
      format.html 
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.json { render json: {comment: @comment},status: :ok}
    end  
  end

  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.json { render json: {comment: @comment},status: :ok }
      format.html
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: {comment: "Not found" }, status: :unprocessable_entity }
      format.html
    end
  end

  def new
    @comment=Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      respond_to do |format|
        format.json { render json: {comment: @comment}, status: :ok }
        format.html { redirect_to article_comments_path} 
      end  
    else
      respond_to do |format|
        format.json { render json: {comment: @comment}, status: :unprocessable_entity }
        format.html { render 'edit' }
      end
    end
    rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: {comment: "Not found" }, status: :unprocessable_entity }
      format.html
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article)}
      format.json { render json:{article: @article},status: :ok}
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: {article: "Not found" }, status: :unprocessable_entity }
      format.html
    end
  end 

  private 
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end