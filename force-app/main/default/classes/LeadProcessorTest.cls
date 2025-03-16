@isTest
private class LeadProcessorTest {

    @testSetup
    static void setup() {
        // Crear 200 registros de Lead para la prueba
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'TestCompany' + i,
                LeadSource = 'Old Source' // Inicialmente el LeadSource está como 'Old Source'
            ));
        }
        insert leads;
    }

    @isTest
    static void testLeadProcessor() {
        // Iniciar la prueba
        Test.startTest();
        
        // Crear una instancia de LeadProcessor y ejecutar el batch
        LeadProcessor batch = new LeadProcessor();
        Id batchId = Database.executeBatch(batch, 200); // Tamaño de batch de 100 para procesar los registros en lotes más pequeños
        
        // Detener la prueba para que el batch se ejecute y podamos hacer las verificaciones
        Test.stopTest();

        // Verificar que todos los registros de Lead se han actualizado correctamente
        Integer updatedLeadsCount = [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeadsCount, 'Todos los registros de Lead deben tener LeadSource actualizado a "Dreamforce".');
        
        // Verificar que el Job se ha completado correctamente (esto cubre el método finish)
        List<AsyncApexJob> jobs = [SELECT Status, JobItemsProcessed FROM AsyncApexJob WHERE Id = :batchId];
        System.assertEquals('Completed', jobs[0].Status, 'El batch job debería haber completado exitosamente.');
        System.assertEquals(200, jobs[0].JobItemsProcessed, 'Todos los registros deben haber sido procesados.');

        // Confirmar que el método finish se ha ejecutado
        System.debug('Batch job finished: ' + jobs[0].Status);
    }
}