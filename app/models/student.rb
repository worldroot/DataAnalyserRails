class Student < ApplicationRecord

  def prediction
    if self.scoreAstre > self.scoreIps
      self.predictedPath = "Astre"
    elsif self.scoreAstre < self.scoreIps
      self.predictedPath = "Ips"
    else
      self.predictedPath = "Astre/Ips"
    end
  end
end
