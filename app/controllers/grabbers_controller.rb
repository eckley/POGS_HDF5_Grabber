class GrabbersController < ApplicationController
  def new
    @grabber = Grabber.new

  end

  def create
    @grabber = Grabber.new(params[:grabber])
    if @grabber.valid?
      #TODO send request, use pid = Process.spawn("cmd") and Process.detach(pid)
      ##  Process.spawn("python", "extract_from_hdf5.py", @grabber.galaxy, @grabber.feature, @grabber.layer, '-0 '  )
      #   Process.detach
      #
      ##  Or if ssh is required see http://johanharjono.com/archives/602
      flash[:notice] = "Request sent!"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end