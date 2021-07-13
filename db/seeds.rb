# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Card.all.count != 81
    Card.destroy_all

    3.times do |shape|
        3.times do |color|
            3.times do |count|
                3.times do |fill|
                    Card.create shape: shape, color: color, count: count, fill: fill
                end
            end
        end
    end
end