class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  http_basic_authenticate_with name: "HHH", password: "WWE",except: [:index, :show]

  def index
    @articles = Article.all
    respond_to do |format|
      format.json { render json: {status: 'SUCCESS',  articles: @articles},status: :ok }
      format.html 
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.json { render json: {status: 'SUCCESS', article: @article , comments: @article.comments}, status: :ok }
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
        format.json { render json: {status: 'SUCCESS', message: 'Article created SUCCESSFULLY',article: @article}, status: :ok }
        format.html { redirect_to @article }
      end
    else
      respond_to do |format|
        format.json { render json: {status: 'Error', message: 'Article NOT CREATED',article: @article}, status: :unprocessable_entity }
        format.html { render 'new' }
      end
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      respond_to do |format|
        format.json { render json: {status: 'SUCCESS', article: @article}, status: :ok }
        format.html { redirect_to @article }
      end  
    else
      respond_to do |format|
        format.json { render json: {status: 'Error', message: 'Article NOT UPDATED',article: @article}, status: :unprocessable_entity }
        format.html { render 'edit' }
      end
    end
  end


  def destroy
    p 'adwad'
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.json { render json: {status: 'SUCCESS', message: 'article deleted SUCCESSFULLY'}, status: :ok }
      format.html { redirect_to articles_path }
    end 
  end 

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end 

end
