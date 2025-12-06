class User < ApplicationRecord
    belongs_to :role
    has_secure_password

    validates :email, presence: { message: "No puede estar vacío" },
                      uniqueness: { message: "Ya está en uso" }
    validates :password, length: { minimum: 6, message: "Debe tener al menos 6 caracteres" },
                         allow_blank: true
    validates :name, presence: { message: "No puede estar vacío" }
    validates :surname, presence: { message: "No puede estar vacío" }

    DEFAULT_PASSWORD = "123456"

    # Asignar contraseña por defecto al crear usuario
    before_validation :set_default_password, on: :create

    # Sistema de permisos
    # Verifica si el usuario tiene un permiso específico
    def can?(permission_name)
      return false unless role.present?

      # Busca el permiso por nombre
      permission = Permission.find_by(name: permission_name)
      return false unless permission.present?

      # Verifica si existe la relación en has_permissions
      HasPermission.exists?(role_id: role.id, permission_id: permission.id)
    end

    def self.ransackable_attributes(auth_object = nil)
      [ "name", "surname", "email" ]
    end

    def self.ransackable_associations(auth_object = nil)
      []
    end

    private

    def set_default_password
      self.password = DEFAULT_PASSWORD
      self.password_confirmation = DEFAULT_PASSWORD
      self.must_change_password = true
    end
end
