class Grabber
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :galaxy, :features, :layers, :email

  validates :galaxy, :presence => true
  validates :email, :presence => true
  validate :check_features, :check_layers
  validate :check_email

  def list_of_features
        return  Grabber_defaults['features']
  end
  def list_of_layers
        return Grabber_defaults['layers']
  end

  def check_email
    safe_emails = Grabber_defaults['safe_emails']
    unless email == '' || safe_emails.include?(email)
        errors.add(:email,"Your email has not been authorised, please contact kevin.vinsen [@ ] uwa.edu.au")
    end
  end
  def check_features
    list = list_of_features
    count = 0
    if features
      features.each do |key|
        if list.has_key?(key)
          count += 1
        else
          errors.add(:features,"not valid: #{key}")
        end
      end
    end
    if count == 0
      errors.add(:features,"You must select at least one valid feature")
    end
  end
  def check_layers
    list = list_of_layers
    count = 0
    if layers
      layers.each do |key|
        if list.has_key?(key)
          count += 1
        else
          errors.add(:layers,"not valid: #{key}")
        end
      end
    end
    if count == 0
      errors.add(:layers,"You must select at least one valid layer")
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
  def get_layers
    temp_string = ''
    layers.each do |feature|
      temp_string << feature
      temp_string << ' '
    end
    return temp_string
  end
  def get_features
    temp_string = ''
    features.each do |feature|
      temp_string << feature
      temp_string << ' '
    end
    return temp_string
  end
  def request_string
    return "python #{Grabber_defaults['extract_script_path']} '#{email}' '#{galaxy}' #{get_features} #{get_layers}"
  end
end