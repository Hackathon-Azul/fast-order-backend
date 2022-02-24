# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all
OrderItem.destroy_all
Order.destroy_all
Category.destroy_all
Bill.destroy_all
Table.destroy_all
User.destroy_all


puts 'Criando Usuários'


User.create(name: "Gisele", email: "test@test.com", password: "123456", password_confirmation: "123456")

User.create(name: "Paulo", email: "test3@test.com", password: "123456", password_confirmation: "123456")

User.create(name: "Michael", email: "test2@test.com", password: "123456", password_confirmation: "123456", profile: 2)

User.create(name: "Joao", email: "joao@gmail.com", password: "123456", password_confirmation: "123456", profile: 0)


puts 'Criando Categorias'

Category.create(title: 'Lanches')
Category.create(title: 'Pizza')
Category.create(title: 'Porções')
Category.create(title: 'Marmitex')
Category.create(title: 'Açaí')
Category.create(title: 'Massas')
Category.create(title: 'Pastéis')

puts 'Criando Productos'

Product.create(name: 'Misto quente', avaiable: true, description: 'Pão de forma, mussarela, presunto, alface e maionese', price: 10.50, category_id: 1)
Product.create(name: 'Cachorro quente', avaiable: true, description: '2 salsichas, tomate, alface e maionese', price: 8.50, category_id: 1)
Product.create(name: 'Pastel de carne', avaiable: true, description: 'um pastel recheado com carne', price: 12.50, category_id: 7)
Product.create(name: 'Pastel X-tudo', avaiable: true, description: 'um pastel recheado com carne moida, frango, mussarela, presunto, bacon, calabresa, milho verde e catupiry', price: 12.50, category_id: 7)
Product.create(name: 'Batata', avaiable: true, description: 'uma porça de batata', price: 11.50, category_id: 3)
Product.create(name: 'Calabresa', avaiable: true, description: 'uma porça de calabresa', price: 21.50, category_id: 3)
Product.create(name: 'Peixe', avaiable: true, description: 'uma porça de peixe', price: 21.50, category_id: 3)
Product.create(name: 'Prato do dia', avaiable: true, description: 'uma marmitex composta de arroz, feijão, baião, com uma mistura do dia (bife acebolado, bisteca suína, peixe frito, filé de frango e etc), acompanhado de salada ou uma farofa normal', price: 16.50, category_id: 4)
Product.create(name: 'Pizza de mussarela', avaiable: true, description: 'uma deliciosa piza de mussarela com tomate', price: 28.50, category_id: 2)
Product.create(name: 'Pizza de calabresa', avaiable: true, description: 'uma deliciosa piza de calabresa, cebola e mussarela', price: 28.50, category_id: 2)
Product.create(name: 'Pizza de marguerita', avaiable: true, description: 'uma deliciosa piza de mussarela, tomate, provolone e manjericão', price: 28.50, category_id: 2)
Product.create(name: 'Açaí tradicioanal', avaiable: true, description: 'um delicioso pote de açaí', price: 8.50, category_id: 5)
Product.create(name: 'Açaí trufado', avaiable: true, description: 'um delicioso pote de açaí trufado com nutella', price: 15.50, category_id: 5)
Product.create(name: 'Nhoque', avaiable: true, description: 'um delicioso nhoque artesanal coberto por um molho especial da sua escolha!', price: 13.50, category_id: 6)
Product.create(name: 'Panqueca de frango', avaiable: true, description: 'um deliciosa panqueca com frango, milho, bacon e queijo', price: 17.20, category_id: 6)

puts 'Criando Tables'

Table.create(table_number: 1, avaliable_table: true)
Table.create(table_number: 2, avaliable_table: true)
Table.create(table_number: 3, avaliable_table: true)
Table.create(table_number: 4, avaliable_table: true)
Table.create(table_number: 5, avaliable_table: true)
Table.create(table_number: 6, avaliable_table: true)
Table.create(table_number: 7, avaliable_table: true)
Table.create(table_number: 8, avaliable_table: true)
Table.create(table_number: 9, avaliable_table: true)
Table.create(table_number: 10, avaliable_table: true)
Table.create(table_number: 11, avaliable_table: true)
Table.create(table_number: 12, avaliable_table: true)
Table.create(table_number: 13, avaliable_table: true)
Table.create(table_number: 14, avaliable_table: true)
Table.create(table_number: 15, avaliable_table: true)

puts 'Criando Orders'

Order.create(client_name: "Luciano", table_id: 1, user_id: 1,  order_items_attributes: [
    { 
        quantity: 1,
        product_id: 1
    },
    { 
        quantity: 2,
        product_id: 5,
        comments: "quero com mais cebola"
    },
    { 
        quantity: 1,
        product_id: 12
    }
])

Order.create(client_name: "Carla", table_id: 1, user_id: 2,  order_items_attributes: [
    { 
        quantity: 3,
        product_id: 8
    }
])
