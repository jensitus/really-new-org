# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 1,jens@ist-ur.org,$2a$10$q30O8Y/wU3loTLckKfHZhe/7XmwV.aSnOAcYnVpJFn4.fQ44uWCVW,,,2022-03-04 23:27:02.444925,3140,2022-03-16 10:35:36.049118,2022-03-15 20:57:35.118342,62.240.134.108,62.240.134.108,2014-12-13 20:14:40.684129,2022-03-16 13:04:44.893042,jensitus,,2014-12-19 07:28:48.819001,,,jensitus,jens_avatar_2_1.jpg,,,false,,,,,,,,0

user = User.create!(name: "jensitus", email: "jens@ist-ur.org", encrypted_password: "$2a$10$q30O8Y/wU3loTLckKfHZhe/7XmwV.aSnOAcYnVpJFn4.fQ44uWCVW")