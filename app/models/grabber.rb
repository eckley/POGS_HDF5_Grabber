class Grabber
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :galaxy, :features, :layers, :email

  validates :galaxy, :presence => true
  validates :email, :presence => true
  validates :features, :presence => true
  validates :layers, :presence => true
  validate :check_features, :check_layers

  def list_of_features
        return  Hash['--best_fit'=>'-f0','--percentile_50'=>'-f1']
  end
  def list_of_layers
        return Hash['--f_mu_sfh'=>'-l0','--f_mu_ir'=>'l1']
  end

  def check_features
    if features.length == 1
      errors.add(:features,"You must select at least one feature")
    end
    features.each do |feature|
      if !self.list_of_features.value?(feature) && feature != ''
        errors.add(:features,"not valid: #{feature}")
      end
    end
  end
  def check_layers
    if layers.length == 1
      errors.add(:layers,"You must select at least one layer")
    end
    layers.each do |layer|
      if !self.list_of_layers.value?(layer) && layer != ''
        errors.add(:layers,"not valid: #{layer}")
      end
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end