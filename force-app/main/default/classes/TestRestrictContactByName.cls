@isTest
public class TestRestrictContactByName {

    // Caso de prueba para insertar un contacto con un apellido válido
    @isTest
    static void testValidLastNameInsert() {
        // Crear un contacto con un apellido válido
        Contact validContact = new Contact(FirstName = 'Juan', LastName = 'Pérez', Email = 'juan.perez@example.com');
        
        // Insertar el contacto
        insert validContact;

        // Verificar que el contacto fue insertado correctamente
        Contact insertedContact = [SELECT Id, LastName FROM Contact WHERE Id = :validContact.Id];
        System.assertEquals('Pérez', insertedContact.LastName);
    }

    // Caso de prueba para insertar un contacto con un apellido inválido
    @isTest
    static void testInvalidLastNameInsert() {
        // Crear un contacto con el apellido 'INVALIDNAME'
        Contact invalidContact = new Contact(FirstName = 'Carlos', LastName = 'INVALIDNAME', Email = 'carlos.invalid@example.com');
        
        try {
            // Intentar insertar el contacto con un apellido inválido
            insert invalidContact;
            // Si no se lanza una excepción, fallamos la prueba
            System.assert(false, 'The contact should not have been inserted due to the invalid last name.');
        } catch (DmlException e) {
            // Verificar que la excepción tiene el mensaje correcto
            System.assert(e.getMessage().contains('Cannot insert or update a Contact with the last name "INVALIDNAME".'));
        }
    }

    // Caso de prueba para actualizar un contacto con un apellido válido
    @isTest
    static void testValidLastNameUpdate() {
        // Crear un contacto con un apellido válido
        Contact validContact = new Contact(FirstName = 'Luis', LastName = 'Gómez', Email = 'luis.gomez@example.com');
        
        // Insertar el contacto
        insert validContact;

        // Actualizar el apellido del contacto a un valor válido
        validContact.LastName = 'Lopez';
        update validContact;

        // Verificar que el apellido se haya actualizado correctamente
        Contact updatedContact = [SELECT Id, LastName FROM Contact WHERE Id = :validContact.Id];
        System.assertEquals('Lopez', updatedContact.LastName);
    }

    // Caso de prueba para actualizar un contacto con un apellido inválido
    @isTest
    static void testInvalidLastNameUpdate() {
        // Crear un contacto con un apellido válido
        Contact validContact = new Contact(FirstName = 'María', LastName = 'Méndez', Email = 'maria.mendez@example.com');
        
        // Insertar el contacto
        insert validContact;

        // Intentar actualizar el apellido del contacto a 'INVALIDNAME'
        validContact.LastName = 'INVALIDNAME';

        try {
            // Intentar realizar la actualización
            update validContact;
            // Si no se lanza una excepción, fallamos la prueba
            System.assert(false, 'The contact should not have been updated due to the invalid last name.');
        } catch (DmlException e) {
            // Verificar que la excepción tiene el mensaje correcto
            System.assert(e.getMessage().contains('Cannot insert or update a Contact with the last name "INVALIDNAME".'));
        }
    }
}