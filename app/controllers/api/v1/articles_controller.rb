class Api::V1::ArticlesController < ApplicationController
    def index
        @articles = Article.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded articles',data:@articles},status: :ok
    end

    def show
    @article = Article.find(params[:id])
    render json: {status:'SUCCESS',message:'Loaded article',data:@article},status: :ok
    end

    def create
        @article = Article.create(article_params)

        if @article.save
            render json: {status:'SUCCESS',message:'saved article',data:@article},status: :ok
        else
            render json: {status:'Error',message:'article not saved',data:@article.errors},status: :unprocessable_entity
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        render json: {status:'SUCCESS',message:'deleted article',data:@article},status: :ok
    end

    private
    def article_params
    params.permit(:title,:body)
    end
end