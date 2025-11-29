class Client < ApplicationRecord
  has_many :sales
  validates :dni, presence: { message: "no puede estar en blanco" },
                  uniqueness: { message: "ya está registrado" },
                  numericality: { only_integer: true, message: "debe contener solo números" },
                  length: { in: 7..8, message: "debe tener entre 7 y 8 dígitos" }

  validates :name, presence: { message: "no puede estar en blanco" },
                   format: { with: /\A[a-zA-Z\u00C0-\u00FF\s]+\z/, message: "inválido (solo letras)" }

  validates :surname, presence: { message: "no puede estar en blanco" },
                      format: { with: /\A[a-zA-Z\u00C0-\u00FF\s]+\z/, message: "inválido (solo letras)" }

  def full_name
    "#{name} #{surname}"
  end
end
