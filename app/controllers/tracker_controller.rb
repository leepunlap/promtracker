class TrackerController < ApplicationController

  def collect
    
    @logs=[]
    @tid = params['tid']
    @logs.push('Web Application ID : ' + @tid)
    @webapp = Webapp.find_by_appid(@tid)
    @logs.push('Web Application Name : ' + @webapp.name)
    @logs.push('Organization : ' + @webapp.organization.name)
    
    if @webapp.ptobject.nil?
      @logs.push('Creating new ptobj')
      @ptobj = Hash.new
    else
      if @webapp.ptobject.length >= 2
        @ptobj = JSON.parse(@webapp.ptobject)
      else
        @ptobj = Hash.new
      end
    end
    if @ptobj['history'].nil?
      @logs.push('Creating new history')
      @ptobj['history'] = Array.new
    end
    @timezone = "Asia/Hong_Kong"
    @time = Time.now.in_time_zone(@timezone)
    uri = URI(params[:dl])
    @ptobj['history'].push({
      :time => @time,
      :us => uri.scheme,
      :uh => uri.host,
      :up => uri.path,
      :uq => uri.query,
      :uf => uri.fragment,
      :ul => params[:ul],
      :dt => params[:dt],
      :de => params[:de],
      :sd => params[:sd],
      :sr => params[:sr],
      :vp => params[:vp]
    })
    if @ptobj['history'].length > 10
      @ptobj['history'].shift
    end
    @webapp.update_attributes :ptobject => @ptobj.to_json
    render json: {
      status: :ok
    }
  end
  

end