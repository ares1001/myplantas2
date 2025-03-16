public class VerifyDate {
    // Método para verificar si una fecha está dentro de un rango válido
    public static Date getValidDate(Date fechaIngresada, Date fechaInicio, Date fechaFin) {
        // Verifica si la fecha está dentro del rango
        if (fechaIngresada >= fechaInicio && fechaIngresada <= fechaFin) {
            return fechaIngresada; // La fecha es válida, se devuelve tal cual
        } else {
            // Si no está en el rango, devuelve el último día del mes de la fechaFin
            return fechaFin.toStartOfMonth().addMonths(1).addDays(-1);
        }
    }
}