# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#

luke = User.create(name: 'Luke Skywalker') #id: 1
leia = User.create(name: 'Leia Skywalker') #id: 2
padme = User.create(name: 'Padme Amidala') #id: 3
palpatine = User.create(name: 'Senator Palpatine') #id: 4
darth = User.create(name: 'Darth Vader') #id: 5
han = User.create(name: 'Han Solo') #id: 6
chewbacca = User.create(name: 'Chewbacca') #id: 7
lando = User.create(name: 'Lando Calrissian') #id: 8
jabba = User.create(name: 'Jabba the Hutt') #id: 9
boba = User.create(name: 'Boba Fett') #id: 10
jar = User.create(name: 'Jar Jar Binks') #id: 11
c3p0 = User.create(name: 'C3P0') #id: 12
r2d2 = User.create(name: 'R2D2') #id: 13
yoda = User.create(name: 'Yoda') #id: 14

Friendship.create(user_source: luke, user_destine: leia)
Friendship.create(user_source: luke, user_destine: han)
Friendship.create(user_source: luke, user_destine: chewbacca)
Friendship.create(user_source: luke, user_destine: c3p0)
Friendship.create(user_source: luke, user_destine: r2d2)
Friendship.create(user_source: luke, user_destine: yoda)
Friendship.create(user_source: luke, user_destine: darth)

Friendship.create(user_source: leia, user_destine: luke)
Friendship.create(user_source: leia, user_destine: han)
Friendship.create(user_source: leia, user_destine: c3p0)
Friendship.create(user_source: leia, user_destine: r2d2)
Friendship.create(user_source: leia, user_destine: chewbacca)
Friendship.create(user_source: leia, user_destine: darth)

Friendship.create(user_source: padme, user_destine: leia)
Friendship.create(user_source: padme, user_destine: luke)
Friendship.create(user_source: padme, user_destine: jar)
Friendship.create(user_source: padme, user_destine: darth)
Friendship.create(user_source: padme, user_destine: c3p0)
Friendship.create(user_source: padme, user_destine: r2d2)

Friendship.create(user_source: darth, user_destine: leia)
Friendship.create(user_source: darth, user_destine: luke)
Friendship.create(user_source: darth, user_destine: palpatine)
Friendship.create(user_source: darth, user_destine: lando)
Friendship.create(user_source: darth, user_destine: yoda)

Friendship.create(user_source: palpatine, user_destine: darth)

Friendship.create(user_source: han, user_destine: leia)
Friendship.create(user_source: han, user_destine: luke)
Friendship.create(user_source: han, user_destine: chewbacca)
Friendship.create(user_source: han, user_destine: jabba)
Friendship.create(user_source: han, user_destine: lando)

Friendship.create(user_source: chewbacca, user_destine: han)
Friendship.create(user_source: chewbacca, user_destine: leia)
Friendship.create(user_source: chewbacca, user_destine: luke)
Friendship.create(user_source: chewbacca, user_destine: lando)
Friendship.create(user_source: chewbacca, user_destine: jabba)

Friendship.create(user_source: lando, user_destine: chewbacca)
Friendship.create(user_source: lando, user_destine: han)

Friendship.create(user_source: jabba, user_destine: boba)

Friendship.create(user_source: boba, user_destine: jabba)

Friendship.create(user_source: jar, user_destine: padme)

Friendship.create(user_source: c3p0, user_destine: luke)
Friendship.create(user_source: c3p0, user_destine: leia)
Friendship.create(user_source: c3p0, user_destine: padme)
Friendship.create(user_source: c3p0, user_destine: darth)
Friendship.create(user_source: c3p0, user_destine: han)
Friendship.create(user_source: c3p0, user_destine: r2d2)

Friendship.create(user_source: r2d2, user_destine: luke)
Friendship.create(user_source: r2d2, user_destine: leia)
Friendship.create(user_source: r2d2, user_destine: padme)
Friendship.create(user_source: r2d2, user_destine: darth)
Friendship.create(user_source: r2d2, user_destine: han)
Friendship.create(user_source: r2d2, user_destine: c3p0)

Friendship.create(user_source: yoda, user_destine: luke)
Friendship.create(user_source: yoda, user_destine: leia)
Friendship.create(user_source: yoda, user_destine: padme)
Friendship.create(user_source: yoda, user_destine: darth)
