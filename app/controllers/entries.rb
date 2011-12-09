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

    if (time.match(':'))
      hours, minutes = time.split(':')
      @entry.time = hours.to_i * 60 + minutes.to_i
    elsif (time.match(/\d/))
      @entry.time = time
    else
      @entry.errors.add(:time, 'Invalid time.')
    end

    if @entry.errors.count > 0
      render 'projects/show'
    elsif @entry.save
      redirect back
    else
      render 'projects/show'
    end
  end

end
