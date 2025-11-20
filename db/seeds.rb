# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Predefined roles
[ "ADMIN", "GERENTE", "EMPLEADO", "CLIENTE" ].each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

# Crear un usuario admin
admin_role = Role.find_by(name: "ADMIN")

User.find_or_create_by!(email: "admin@gmail.com") do |u|
  u.name = "Admin"
  u.surname = "Admin"
  u.password = "Admin"
  u.role_id = admin_role.id
end



#Crear permisos
["modify_role"].each do |perm_name|
  Permission.find_or_create_by!(name: perm_name)
end

#Asignar permisos a roles
admin_role = Role.find_by(name: "ADMIN")
modify_role_permission = Permission.find_by(name: "modify_role")

RolePermission.find_or_create_by!(role: admin_role, permission: modify_role_permission)



puts "Creando productos de prueba..."

# Imágenes de prueba genéricas (URLs de internet)
image_urls = [
  "https://upload.wikimedia.org/wikipedia/en/4/42/Beatles_-_Abbey_Road.jpg",
  "https://upload.wikimedia.org/wikipedia/en/5/55/Michael_Jackson_-_Thriller.png",
  "https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png",
  "https://upload.wikimedia.org/wikipedia/en/2/2a/Queen_A_Night_At_The_Opera.png"
]

types = [ "Vinilo", "CD" ]
categories = [ "Rock", "Pop", "Jazz", "Metal" ]

12.times do |i|
  # 1. Crear el Producto base
  product = Product.create!(
    name: "Disco Ejemplo Vol. #{i + 1}",
    author: "Artista Genérico #{i + 1}",
    category: categories.sample, # Elige uno al azar
    type: types.sample,          # Elige uno al azar
    price: rand(15000..50000),   # Precio al azar entre 15k y 50k
    description: "Esta es una descripción de prueba para el disco número #{i + 1}. Es una edición limitada muy buscada.",
    upload_date: Time.now
  )

  # 2. Asignarle Stock (Creamos la entrada en new_products)
  # (Asumimos que todos son nuevos para este ejemplo rápido)
  NewProduct.create!(
    product: product,
    stock: rand(1..20)
  )

  # 3. Asignarle una Imagen
  Image.create!(
    product: product,
    url: image_urls.sample # Elige una foto al azar
  )
end

puts "¡Datos de prueba creados con éxito!"
