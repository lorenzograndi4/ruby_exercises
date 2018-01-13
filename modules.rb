module Logging
  def log_my_size
    "#{self.class} (with the id: #{self.object_id}) has a contents length of #{contents.length}"
  end
end

class Upload
  attr_reader :contents
  include Logging

  def initialize(contents = '')
    @contents = contents
  end
end

class PDF < Upload; end

xfer = Upload.new([1,2,3,4])
p xfer.log_my_size

pdf = PDF.new([1,2,3,4,5,6,7,8])
p pdf.log_my_size
p pdf.contents

empty = PDF.new
p empty.log_my_size