class RecipesController < ApplicationController
    before_action :authenticate

    def index
        recipe = Recipe.all
        render json: recipe, each_serializer: RecipeSerializer, status: :ok
    end

    def create
        user = User.find_by(id: session[:user_id])
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: 201
        rescue ActiveRecord::RecordInvalid => invalid
            render json: {errors: [invalid.record.errors]}, status: 422
    end

    private
    def authenticate
        render json: {errors: ["You are not logged in"]}, status: 401 unless session.include? :user_id
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
