class Api::V1::EmployeesController < ApplicationController

    before_action :authorize

    def index
        @employee = Employee.all
        render json: @employee
    end
end
