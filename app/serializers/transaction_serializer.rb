class TransactionSerializer
  include JSONAPI::Serializer

  attributes :payer, :points, :timestamp
end
