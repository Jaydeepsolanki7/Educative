class AssessmentsController < ApplicationController
  def new
    @assessment = Assessment.new(product_id: params[:product_id])
    authorize @assessment
    @product = Product.find(params[:product_id]) if params[:product_id].present?
  end

  def create
    @assessment = Assessment.new(assessment_params)
    authorize @assessment

    if @assessment.save
      @product = @assessment.product
      flash.now[:notice] = "Assessment created successfully."
      render "products/show"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def assessment_params
    params.require(:assessment).permit(:product_id, :title, :description, :duration, :image)
  end
end
