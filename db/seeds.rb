# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


restaurantes = Category.create(name: "Restaurantes")
carro = Category.create(name: "Carro")
hogar = Category.create(name: "Hogar")

Expense.create(category: restaurantes, date: Date.current, concept: "Hamburguesas el burral", amount: 32000)
Expense.create(category: restaurantes, date: Date.current - 4, concept: "Hamburguesas el burral", amount: 45000)
Expense.create(category: carro, date: Date.current, concept: "Gasolina", amount: 80000)
Expense.create(category: hogar, date: Date.current - 6, concept: "Lámparas", amount: 350000)
Expense.create(category: hogar, date: Date.current - 6, concept: "Lámparas", amount: 40000, user_id: 1)
