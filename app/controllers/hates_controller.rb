class HatesController < ApplicationController
  def index
    @hates = Hate.all
  end

  def new
    @hate = Hate.new
  end

  def create
    @hate = Hate.new(params[:hate])
    @hate.user = current_user
    if @hate.save
      redirect_to hates_url, :notice => "Successfully created hate."
    else
      render :action => 'new'
    end
  end

  def destroy
    @hate = Hate.find(params[:id])
    @hate.destroy
    redirect_to hates_url, :notice => "Successfully destroyed hate."
  end
end
