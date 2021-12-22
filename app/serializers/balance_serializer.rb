class BalanceSerializer
  include JSONAPI::Serializer

  attributes :payer, :points
end
