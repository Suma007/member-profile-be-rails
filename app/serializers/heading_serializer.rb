class HeadingSerializer < ActiveModel::Serializer
  attributes :id, :level, :content_value, :created_at, :updated_at
  belongs_to :member
end
