# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 1,jens@ist-ur.org,$2a$10$q30O8Y/wU3loTLckKfHZhe/7XmwV.aSnOAcYnVpJFn4.fQ44uWCVW,,,2022-03-04 23:27:02.444925,3140,2022-03-16 10:35:36.049118,2022-03-15 20:57:35.118342,62.240.134.108,62.240.134.108,2014-12-13 20:14:40.684129,2022-03-16 13:04:44.893042,jensitus,,2014-12-19 07:28:48.819001,,,jensitus,jens_avatar_2_1.jpg,,,false,,,,,,,,0
#

connection = ActiveRecord::Base.connection()
connection.execute("
UPDATE public.users SET avatar = 'yoda.jpg' WHERE id = 26;
UPDATE public.users SET avatar = 'facepalm.jpg' WHERE id = 8;
UPDATE public.users SET avatar = 'tumblr_nufx8mozXP1qb24s0o1_250.png' WHERE id = 25;
UPDATE public.users SET avatar = 'trip_pic.jpg' WHERE id = 29;
UPDATE public.users SET avatar = 'image.jpeg' WHERE id = 49;
UPDATE public.users SET avatar = 'DSCN1346.JPG' WHERE id = 27;
UPDATE public.users SET avatar = 'hallo_spencer_lexi.gif' WHERE id = 19;
UPDATE public.users SET avatar = 'square_white.jpg' WHERE id = 28;
UPDATE public.users SET avatar = 'eliasskifahrer.jpg' WHERE id = 4;
UPDATE public.users SET avatar = 'dog.png' WHERE id = 56;
UPDATE public.users SET avatar = '1980-Safaripark_G_nserndorf__IMG_0006.jpg' WHERE id = 54;
UPDATE public.users SET avatar = 'IMG_3169.jpg' WHERE id = 50;
UPDATE public.users SET avatar = 'bitmoji.png' WHERE id = 70;
UPDATE public.users SET avatar = 'image.jpeg' WHERE id = 53;
UPDATE public.users SET avatar = '2017-07-13_21.01.04.jpg' WHERE id = 61;
UPDATE public.users SET avatar = '551624.png' WHERE id = 6;
UPDATE public.users SET avatar = 'jens_avatar_2_1.jpg' WHERE id = 1;
UPDATE public.users SET avatar = 'me.jpg' WHERE id = 14;
UPDATE public.users SET avatar = 'BorgCubus.jpg' WHERE id = 20;
UPDATE public.users SET avatar = 'Pingu.gif' WHERE id = 3;
UPDATE public.users SET avatar = 'Profilbild_Fabian.jpg' WHERE id = 7;
")