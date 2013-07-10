class Chargify2::Response
  attr_reader :status_code
  attr_reader :errors
  attr_reader :resource
  attr_reader :meta

  def initialize(resource, meta)
    @resource    = resource
    @meta        = (meta || {}).symbolize_keys
    @status_code = @meta[:status_code]
    @errors      = @meta[:errors] || []
  end

  def successful?
    status_code.to_s == '200'
  end

  def errors?
    @errors.any?
  end

end
