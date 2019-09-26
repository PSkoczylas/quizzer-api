module Serializable
  extend ActiveSupport::Concern

  def serialize(data)
    @serializer.new(data)
  end
end
