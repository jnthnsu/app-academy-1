class Api::BenchesController < ApplicationController
  def index
    if params[:bounds]
      @benches = Bench.in_bounds(params[:bounds])
    else
      @benches = Bench.all
    end
  end

  def create
    @bench = Bench.new(bench_params)
    if @bench.save
      @bench
    else
      @errors = @bench.errors.full_messages
    end
  end

  private

  def bench_params
    params.require(:bench).permit(:description, :seating, :lat, :lng)
  end
end
