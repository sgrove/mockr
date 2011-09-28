class Setting < ActiveRecord::Base
  before_save :set_bushido_env
  
  def self.[](key)
    self.find_by_key(key.to_s).try(:value)
  end

  def set_bushido_env
    if self.key == "subdomain"
      Bushido::App.set_subdomain(self.value) if Bushido::App.subdomain_available?(self.value)
    elsif self.key == "domain"
      Bushido::App.add_domain self.value 
    end
  end

end
