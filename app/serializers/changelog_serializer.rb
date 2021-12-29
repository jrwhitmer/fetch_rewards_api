class ChangelogSerializer
  include JSONAPI::Serializer

  attributes :payer, :points
end
