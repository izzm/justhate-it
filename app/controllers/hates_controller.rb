class HatesController < ApplicationController  
  before_filter :check_user, :only => [:create]
  
  def index
    @hate = Hate.new
    @hates = Hate.last(10)
  end

  def create    
    @hate = Hate.new(params[:hate])
    @hate.user = current_user
    if @hate.save
      redirect_to hates_url, :notice => "Successfully created hate."
    else
      @hates = []
      render :action => 'new'
    end
  end

  def destroy
    @hate = Hate.find(params[:id])
    @hate.destroy
    redirect_to hates_url, :notice => "Successfully destroyed hate."
  end
end
