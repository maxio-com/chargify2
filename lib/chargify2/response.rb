class Chargify2::Response
  attr_reader :status_code
  attr_reader :errors
  attr_reader :resource
  attr_reader :meta

  def initialize(resource, meta)
    @resource    = resource
    @meta        = meta || {}
    @status_code = @meta['status_code']
    @errors      = @meta['errors']
  end

  def successful?
    status_code.to_s == '200'
  end

  #def current_page 
  #end

  #def page_count
  #end
end
