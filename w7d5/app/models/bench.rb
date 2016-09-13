class Bench < ActiveRecord::Base
  def self.in_bounds bounds
    bounds = bounds.values

    lats = bounds.map{|bound| bound.first.to_f}.sort
    lngs = bounds.map{|bound| bound.last.to_f}.sort

    Bench.all.select do |bench|
      bench.lat.between?(*lats) &&
        bench.lng.between?(*lngs)
    end
  end
end
