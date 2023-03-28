

class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_by
    toy.update(likes: toy.likes + 1)
    render json: toy
  end

  def destroy
    toy = find_by
    toy.destroy
    head :no_content
  end

  private


  def find_by
    Toy.find_by(id: params[:id])
  end
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end
end
