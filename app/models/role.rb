class Role < ApplicationRecord
    # Relaciones
    has_many :has_permissions, dependent: :destroy

    validates :name, presence: true, uniqueness: true  # Para que db:seed no cree roles duplicados
end
