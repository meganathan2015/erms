# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# enum role: { super_admin: 0, admin: 1, manager: 2, employee: 3 }
User.destroy_all
UserManagement.destroy_all

# user = User.create(first_name: "Guruprasad", last_name: "MC", phone: "1234567890", role: 1, email: "guruprasad@rayabharitech.com", password: "guru@123", password_confirmation: "guru@123")
# user = User.create(first_name: "Yogesh", last_name: "G", phone: "9898989898", role: 2, email: "yogesh@rayabharitech.com", password: "yogesh@123", password_confirmation: "yogesh@123")

# user_management = UserManagement.create(first_name: "Guruprasad", last_name: "MC", phone: "1234567890", role: 1, email: "guruprasad@rayabharitech.com", password: "guru@123", password_confirmation: "guru@123")
# user_management = UserManagement.create(first_name: "Yogesh", last_name: "G", phone: "9898989898", role: 2, email: "yogesh@rayabharitech.com", password: "yogesh@123", password_confirmation: "yogesh@123")






User.create([{
    first_name: "Guruprasad", 
    last_name: "MC", 
    phone: "1234567890", 
    role: 1, 
    email: "guruprasad@rayabharitech.com", 
    password: "guru@123", 
    password_confirmation: "guru@123"
  },
 
  {
    first_name: "Yogesh", 
    last_name: "G", 
    phone: "9898989898", 
    role: 2, 
    email: "yogesh@rayabharitech.com", 
    password: "yogesh@123", 
    password_confirmation: "yogesh@123"
  }])
  
  p "Created #{User.count} users"

  UserManagement.create([{
    first_name: "Guruprasad", 
    last_name: "MC", 
    phone: "1234567890", 
    role: 1, 
    email: "guruprasad@rayabharitech.com", 
    password: "guru@123", 
    password_confirmation: "guru@123",
    status: "Active"
  },

  {
    first_name: "Yogesh", 
    last_name: "G", 
    phone: "9898989898", 
    role: 2, 
    email: "yogesh@rayabharitech.com", 
    password: "yogesh@123", 
    password_confirmation: "yogesh@123",
    status: "Active"
  }])
  
  p "Created #{UserManagement.count} usermanagements"