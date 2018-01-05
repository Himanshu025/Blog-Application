module Api
 module V1
   class ArticlesController < ApplicationController
     
        # def index
        #   articles = Article.order('created_at DESC');
        #   render json: {status: 'SUCCESS', message:'Loaded acticles', articles:articles},status: :ok
        def index
          articles = Article.all;
                respond_to do |format|
                  format.json { render json: {status: 'SUCCESS', message: 'Loaded all articles', articles: articles},status: :ok }
                  format.html { redirect_to articles_path}
                end
        end

        def show
          article = Article.find(params[:id])
             respond_to do |format|
             	format.json{ render json: {status: 'SUCCESS', message:'Loaded acticle', article:article},status: :ok}
             	format.html{ redirect_to article_path}
             end
        end
        
        def create
           article = Article.create(article_params)
           if article.save
            respond_to do |format|
              format.json{ render json: {status: 'SUCCESS', message:'Saved acticle', data:article},status: :ok }
              format.html{ redirect_to articles_path}
            end
           else
            respond_to do |format|
              format.json{ render json: {status: 'ERROR', message:'Article not Saved', data:article.errors},status: :unprocessable_entity }
              format.html{ redirect_to articles_path}
            end
           end

        end

        def destroy
           article = Article.find(params[:id])
           article.destroy
           render json: {status: 'SUCCESS', message:'Deleted Articles', data:article},status: :unprocessable_entity
         
        end

        def update
           article = Article.find(params[:id])
           if article.update_attributes(article_params)
           render json: {status: 'SUCCESS', message:'article updated', data:article},status: :ok
           else
           render json: {status: 'ERROR', message:'Article not Updated', data:article.errors},status: :unprocessable_entity
           end	
        end

        private 

        def article_params
           params.permit(:title, :body)
        end  
   end
 end
end
