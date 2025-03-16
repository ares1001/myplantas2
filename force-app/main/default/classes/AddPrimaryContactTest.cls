@isTest
private class AddPrimaryContactTest {

    @testSetup
    static void setup() {
        // Crear y agregar 50 cuentas con BillingState 'NY'
        List<Account> nyAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            nyAccounts.add(new Account(
                Name = 'NY Account ' + i,
                BillingState = 'NY'
            ));
        }
        insert nyAccounts;

        // Crear y agregar 50 cuentas con BillingState 'CA'
        List<Account> caAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            caAccounts.add(new Account(
                Name = 'CA Account ' + i,
                BillingState = 'CA'
            ));
        }
        insert caAccounts;
    }

    @isTest
    static void testAddPrimaryContact() {
        // Crear un contacto que se utilizará para la prueba
        Contact contact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test@example.com'
        );

        // Crear una instancia de AddPrimaryContact para el estado 'CA'
        AddPrimaryContact job = new AddPrimaryContact(contact, 'CA');

        // Iniciar la prueba
        Test.startTest();
        System.enqueueJob(job);  // Poner en cola el trabajo
        Test.stopTest();

        // Verificar que se hayan insertado 50 contactos con el estado 'CA'
        Integer insertedContactsCount = [SELECT COUNT() FROM Contact WHERE Email = 'test@example.com'];
        System.assertEquals(50, insertedContactsCount, 'Se deben insertar 50 contactos para las cuentas de CA.');
    }
}