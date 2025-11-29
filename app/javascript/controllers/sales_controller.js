import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    updateStock(event) {
        const select = event.target
        const selectedOption = select.options[select.selectedIndex]
        const stock = parseInt(selectedOption.dataset.stock) || 0

        // Encontrar el input de cantidad y el span de info en el mismo contenedor
        const container = select.closest(".nested-fields")
        const quantityInput = container.querySelector("input[type='number']")
        const stockInfo = container.querySelector(".stock-info")

        if (stock > 0) {
            quantityInput.max = stock
            quantityInput.disabled = false
            stockInfo.textContent = `Stock disponible: ${stock}`
            stockInfo.style.color = "#64748b" // Color normal

            // Si la cantidad actual supera el stock, ajustarla
            if (parseInt(quantityInput.value) > stock) {
                quantityInput.value = stock
            }
        } else {
            quantityInput.value = 0
            quantityInput.disabled = true
            stockInfo.textContent = "Sin stock disponible"
            stockInfo.style.color = "#ef4444" // Rojo alerta
        }
    }

    validateQuantity(event) {
        const input = event.target
        const max = parseInt(input.max)

        if (max && parseInt(input.value) > max) {
            input.value = max
        }
    }
}
