class User < ApplicationRecord
    belongs_to :role
    has_secure_password

    validates :email, presence: { message: "No puede estar vacío" },
                      uniqueness: { message: "Ya está en uso" }
    validates :password, length: { minimum: 6, message: "Debe tener al menos 6 caracteres" }, 
                         allow_blank: true
    validates :name, presence: { message: "No puede estar vacío" }
    validates :surname, presence: { message: "No puede estar vacío" }
end
