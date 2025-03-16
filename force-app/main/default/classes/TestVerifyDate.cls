@isTest
public class TestVerifyDate {
    // Método de prueba para verificar el comportamiento del método getValidDate
    @isTest
    public static void testGetValidDate() {
        // Fechas de prueba
        Date fechaInicio = Date.newInstance(2024, 1, 1); // 1 de enero de 2024
        Date fechaFin = Date.newInstance(2024, 12, 31); // 31 de diciembre de 2024

        // Caso 1: Fecha dentro del rango
        Date fechaDentroDelRango = Date.newInstance(2024, 6, 15); // 15 de junio de 2024
        Date resultado = VerifyDate.getValidDate(fechaDentroDelRango, fechaInicio, fechaFin);
        System.assertEquals(fechaDentroDelRango, resultado, 'La fecha debería ser válida');

        // Caso 2: Fecha fuera del rango
        Date fechaFueraDelRango = Date.newInstance(2025, 1, 15); // 15 de enero de 2025
        Date resultadoFuera = VerifyDate.getValidDate(fechaFueraDelRango, fechaInicio, fechaFin);
        Date ultimoDiaDelMes = Date.newInstance(2024, 12, 31); // Último día del mes de fechaFin
        System.assertEquals(ultimoDiaDelMes, resultadoFuera, 'La fecha debería ajustarse al último día del mes de fechaFin');
    }
}