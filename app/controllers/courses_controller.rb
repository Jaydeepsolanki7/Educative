class CoursesController < ApplicationController
  def new
    @course = Course.new(product_id: params[:product_id])
    @product = Product.find(params[:product_id]) if params[:product_id].present?
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      @product = @course.product
      flash.now[:notice] = "Course created successfully."
      render "products/show"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def search
    @product = Product.find(params[:product_id])

    query_param = params[:q]
    Rails.logger.info ">>> Search query param: #{query_param.inspect}"

    query = query_param.to_s.strip.downcase
    Rails.logger.info ">>> Processed query: #{query.inspect}"

    @courses =
      if query.present?
        like_value = "%#{query}%"
        Rails.logger.info ">>> LIKE argument: #{like_value.inspect}"
        @product.courses.where("LOWER(title) LIKE ?", like_value)
      else
        @product.courses.none
      end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "courses_list",
          partial: "courses/list",
          locals: { courses: @courses, product: @product }
        )
      end

      format.html do
        render partial: "courses/list",
               locals: { courses: @courses, product: @product }
      end
    end
  end

  private

  def course_params
    params.require(:course).permit(:product_id, :title, :description, :difficulty, :image)
  end
end
