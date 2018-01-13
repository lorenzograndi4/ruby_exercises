module Print
  def print_details
    "#{ self.class } (id: #{ file_id }) started at #{ time } by #{
      self.is_a?(Download) ? downloaded_by : "unknown"
    }"
  end
end

class Transfer
  attr_reader :file_id, :time
  include Print

  def initialize(id)
    @file_id = id
    @time = Time.now.strftime("%d/%m/%Y")
  end
end

class Download < Transfer
  attr_reader :downloaded_by

  def initialize(id, name)
    @downloaded_by = name
    super(id)
  end
end

transfers = [Transfer.new(1), Transfer.new(2)]
downloads = [Download.new(1, "Arno Fleming"), Download.new(2, "Mike Farrell"), Download.new(3, "Wouter de Vos")]

transfers.each { |u| puts u.print_details }
downloads.each { |d| puts d.print_details }
