TenThousandHoursApp.controllers :entries, :parent => :projects do

  post :create do

    entry = params[:entry]
    date = entry[:date]
    time = entry[:time]

    @entry = Entry.new
    @project = Project.get(params[:project_id])

    @entry.project = @project
    @entry.description = entry[:description]

    begin
      date = Date.parse(date)
      @entry.date = date;
    rescue
      @entry.errors.add(:date, 'Invalid date.')
    end

    begin
      time = Date.parse(time)
      @entry.time = time;
    rescue
      @entry.errors.add(:time, 'Invalid time.')
    end

    if @entry.errors
      render 'projects/show'
    elsif @entry.save
      redirect back
    else
      render 'projects/show'
    end
  end

end
