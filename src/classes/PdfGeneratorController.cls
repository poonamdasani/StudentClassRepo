public with sharing class PdfGeneratorController {
    private Student__c student{get;set;}
    
    public PdfGeneratorController(ApexPages.StandardController controller){
        this.student = (Student__c)Controller.getRecord();
    }
    
    public PageReference savePdf() {
        PageReference pdf = Page.pdfGeneratorTemplate;
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id',student.id);
        // create the new attachment
        Attachment attach = new Attachment();
        // the contents of the attachment from the pdf
        Blob body;
        //try {
            // returns the output of the page as a PDF
            body = pdf.getContent();
            
            // need to pass unit test -- current bug    
        //} catch (VisualforceException e) {
            //body = Blob.valueOf('Some Text');
        //}
        // delete if pdf present previously
        delete[select Id from Attachment where ParentId = :student.Id and Name = 'Student Detail.pdf'];
        attach.Body = body;
        // add the user entered name
        attach.Name ='Student Detail.pdf';
        attach.IsPrivate = false;
        attach.ParentId = student.Id;
        // attach the pdf to the account
        insert attach;
        pdf.setRedirect(true);
        // send the user to the account to view results
        return pdf;
    }

}