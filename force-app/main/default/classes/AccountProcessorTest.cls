@isTest
private class AccountProcessorTest {
    @isTest
    static void testCountContacts() {
        // Configurar datos de prueba: Crear una cuenta y contactos asociados
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Crear y asociar algunos contactos a la cuenta de prueba
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(FirstName = 'Test', LastName = 'Contact' + i, AccountId = testAccount.Id));
        }
        insert contacts;

        // Llamar al método @future para contar los contactos
        Set<Id> accountIds = new Set<Id>{testAccount.Id};
        AccountProcessor.countContacts(accountIds);

        // Esperar a que termine la transacción asincrónica
        Test.startTest();
        Test.stopTest();

        // Consultar la cuenta actualizada y verificar el número de contactos
        Account updatedAccount = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(5, updatedAccount.Number_Of_Contacts__c, 'El número de contactos debe ser 5');
    }
}