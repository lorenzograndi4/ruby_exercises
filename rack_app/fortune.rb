class Fortune
  # A class method that does a system call.
  # Not the safest of things for production
  def self.wisdom
    `fortune`
  end

  def self.http
    Proc.new do |env|
      ['200', { 'Content-Type' => 'text/plain' }, [Fortune.wisdom]]
    end
  end
end
