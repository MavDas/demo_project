# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
r1 = Role.create({name: "Regular", description: "Can be added to groups and view public groups"})
r2 = Role.create({name: "Admin", description: "Can read and create Groups. Can be added to groups"})
r3 = Role.create({name: "Superadmin", description: "Can perform any CRUD operation on any resource"})

u1 = User.create({name: "Aman", email: "amanvimal@gmail.com", password: "password", password_confirmation: "password", role_id: r3.id, approved: "true", confirmed_at: Time.now.utc })
u2 = User.create({name: "Maverick", email: "amanvimal@hotmail.com", password: "password", password_confirmation: "password", role_id: r1.id, approved: "true", confirmed_at: Time.now.utc })
u3 = User.create({name: "Akash", email: "akash@gmail.com", password: "password", password_confirmation: "password", role_id: r2.id, approved: "true", confirmed_at: Time.now.utc })
u4 = User.create({name: "Prajapati", email: "praja@gmail.com", password: "password", password_confirmation: "password", role_id: r1.id, approved: "true", confirmed_at: Time.now.utc })
u4 = User.create({name: "Vimal", email: "vimal@gmail.com", password: "password", password_confirmation: "password", role_id: r1.id, approved: "true", confirmed_at: Time.now.utc })