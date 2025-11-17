class Role < ApplicationRecord
    validates :name, presence: true, uniqueness: true  #Para que db:seed no cree roles duplicados
end
