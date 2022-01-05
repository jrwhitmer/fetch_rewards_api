# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@transaction_1 = Transaction.create!(payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z")
@transaction_2 = Transaction.create!(payer: "UNILEVER", points: 200, timestamp: "2020-10-31T11:00:00Z")
@transaction_3 = Transaction.create!(payer: "DANNON", points: -200, timestamp: "2020-10-31T15:00:00Z" )
@transaction_4 = Transaction.create!(payer: "MILLER COORS", points: 10000, timestamp: "2020-11-01T14:00:00Z" )
@transaction_5 = Transaction.create!(payer: "DANNON", points: 300, timestamp: "2020-10-31T10:00:00Z")
@balance_1 = Balance.create!(payer: "DANNON", points: 1100)
@balance_2 = Balance.create!(payer: "UNILEVER", points: 200)
@balance_3 = Balance.create!(payer: "MILLER COORS", points: 10000)
