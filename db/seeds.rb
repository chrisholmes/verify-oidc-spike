# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
pid = "oiewuroiqweurwqoeir"
User.create(pid: pid, first_name: "Clark", last_name: "kent", nhs_number: "1234567890")
