@isTest
private class DailyLeadProcessorTest {

    @isTest
    static void testDailyLeadProcessor() {
        // Crear 200 registros de Lead con LeadSource vacío
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'Héroe', LastName = 'Nuevo ' + i, Company = 'Fundación Dreamforce', LeadSource = null));
        }
        insert leads;

        // Verificar que los registros se insertaron correctamente
        List<Lead> insertedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = NULL];
        System.assertEquals(200, insertedLeads.size(), 'Debe haber 200 Leads con LeadSource vacío.');

        // Programar el trabajo de Apex para ejecutar la clase DailyLeadProcessor
        String cronExpression = '0 0 9 * * ?'; // Ejecución diaria a las 9 AM
        DailyLeadProcessor processor = new DailyLeadProcessor();
        
        // Iniciar prueba
        Test.startTest();
        
        // Ejecutar el trabajo programado
        String jobId = System.schedule('Daily Lead Processor Job', cronExpression, processor);
        
        // Detener prueba para ejecutar el trabajo programado inmediatamente
        Test.stopTest();

        // Verificar que todos los registros de Lead fueron actualizados con el valor 'Dreamforce'
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'Todos los registros de Lead deben tener LeadSource como Dreamforce.');

        // Verificar que no haya más registros con LeadSource vacío
        List<Lead> remainingLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = NULL];
        System.assertEquals(0, remainingLeads.size(), 'No debe haber registros con LeadSource vacío después de la actualización.');
    }
}