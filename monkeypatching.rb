require 'active_support/core_ext/numeric/time'

class Numeric
  def days_from_now
    self.days.from_now
  end
end

class String
  def l33t
    gsub('e','3')
  end
end

p ("Leet leet leet").l33t

p 2.5.days_from_now
sleep 2
p 2.5.days_from_now