class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_method 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
      render json: Student.all
    end

    def show
        student = find_student
        render json: student
    end

    def create
        student = Student.created!(student_params)
        render json: student, status: :created
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = find_student
        student.destroy
        render status: :no_content
    end

    private
    def find_student
        Student.find_by!(id: params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def invalid_record_method e
        render json: {errors: e.record.errors}, status: :unprocessable_entity
    end

    def record_not_found
        render json: {error: 'Record not found'}, status: :not_found
    end

    
end
