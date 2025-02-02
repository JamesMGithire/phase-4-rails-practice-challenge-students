class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_method
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def index
        render json: Instructor.all
    end

    def show
        instructor = find_instructor
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = find_instructor
        instructor.destroy
        render status: :no_content
    end
    private
    def find_instructor
        Instructor.find_by!(id: params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def record_not_found
        render json: { error: 'Record not found' }, status: :not_found
    end

    def unprocessable_entity_method e
        render json: {errors: e.record.errors}, status: :unprocessable_entity
    end
end
