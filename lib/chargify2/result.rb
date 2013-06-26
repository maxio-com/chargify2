class Chargify2::Result
  attr_reader :status_code
  attr_reader :errors
  attr_reader :resource

  def initialize(resource, status_code, errors)
    @status_code = status_code
    @errors      = errors
    @resource    = resource
  end

  def method_missing(meth, *args, &block)
    resource.send(meth, *args, &block)
  end

  def successful?
    status_code.to_s == '200'
  end
end
