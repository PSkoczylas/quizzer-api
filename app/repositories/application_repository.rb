class ApplicationRepository
  def initialize(model)
    @model = model
  end

  def method_missing(m, *args, &block)
    @model.send(m, *args)
  end

  def new(*args)
    @model.new(*args)
  end
end