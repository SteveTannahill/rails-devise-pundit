class LabelsController < ApplicationController
  def new
    @label = Label.new
    @labels = Label.all
  end

  def create
    @label = Label.new(label_params)

    respond_to do |format|
      if @label.save
        @labels = Label.all
        format.html { redirect_to new_label_path, notice: 'Label was successfully created.' }
        format.json { render :new, status: :created, location: new_label_path }
      else
        @labels = Label.all
        format.html { render :new }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def index
    @labels = Label.all
    respond_to do |format|
      format.html { redirect_to @label, notice: 'Label was successfully created.' }
      format.json { render :json, status: :created, location: params[:return_loc] }
    end
  end

  private

  def label_params
    params.require(:label).permit(:name, :colour)
  end
end
