class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index ,:show]
  def index
    @articles = Article.all
    respond_to do |format|
      format.json { render json: {articles: @articles},status: :ok }
      format.html 
    end
  end
 
  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.json { render json: { articles: @article, comments:@article.comments },status: :ok }
      format.html
    end
    rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { article: "Not found" }, status: :unprocessable_entity }
      format.html
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      respond_to do |format|
        format.json { render json: {article: @article}, status: :ok }
        format.html { redirect_to @article }
      end
    else
      respond_to do |format|
        format.json { render json: {article: @article}, status: :unprocessable_entity }
        format.html { render 'new' }
      end
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      respond_to do |format|
        format.json { render json: {article: @article}, status: :ok }
        format.html { redirect_to @article }
      end  
    else
      respond_to do |format|
        format.json { render json: {article: @article}, status: :unprocessable_entity }
        format.html { render 'edit' }
      end
    end
    rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { article: "Not found" }, status: :unprocessable_entity }
      format.html
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.json { render json: {article: @article}, status: :ok}
      format.html { redirect_to articles_path }
    end 
    rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { article: "Not found" }, status: :unprocessable_entity }
      format.html
    end
  end 

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end 
end