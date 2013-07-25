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

  def total_count
    @meta[:total_count] || 0
  end

  def current_page
    @meta[:current_page] || 0
  end

  def total_pages
    @meta[:total_pages] || 0
  end
end
