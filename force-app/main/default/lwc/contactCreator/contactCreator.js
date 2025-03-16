import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// Import the fields from Salesforce schema
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';

export default class ContactCreator extends LightningElement {
    // Fields for the form
    fields = [FIRST_NAME, LAST_NAME, EMAIL];

    // Event handler for the success event
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Contact Created',
            message: 'Contact ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}