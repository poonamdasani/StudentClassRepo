public with sharing class PdfGeneratorController 
{
    private Student__c student{get;set;}
    
    public PdfGeneratorController(ApexPages.StandardController controller)
    {
        this.student = (Student__c)Controller.getRecord();
    }
    
    public PageReference savePdf() {
        PageReference pdf = Page.pdfGeneratorTemplate;
        pdf.getParameters().put('id',student.id);
        Attachment attach = new Attachment();
        Blob body;
        body = pdf.getContent();
        delete[select Id from Attachment where ParentId = :student.Id and Name = 'Student Detail.pdf'];
        attach.Body = body;
        attach.Name ='Student Detail.pdf';
        attach.IsPrivate = false;
        attach.ParentId = student.Id;
        insert attach;
        pdf.setRedirect(true);
        return pdf;
    }

}