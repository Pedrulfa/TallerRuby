class HasPermission < ApplicationRecord
    # Relaciones
    belongs_to :role
    belongs_to :permission
    
    # Validar que no se repita la misma combinación de rol y permiso
    validates :role_id, uniqueness: { scope: :permission_id }
end
