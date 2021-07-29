@isTest
public class CS_WidgetIsValueProperlyNestedTest {
    //Generate widget method to be use in every test
    public static Widget__c dataFactory(String value){

        Widget__c widget = new Widget__c(
            CS_Value__c = value            
        );
        insert widget;
        return widget;

    }
    
    @isTest
    public static void properlyNestedTest() {

        String value = '{[()(){[()]}]}';
        Boolean result; 
        Boolean expected = true;         

        Test.startTest();
            result = CS_WidgetIsValueProperlyNested.checkValue(value);
        Test.stopTest();

        System.assertEquals(expected, result, 'Expected result is ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void properlyNestedTestWithText() {

        String value = 'aeiou{aeiou[(aeiou)(aeiou){aeiou[(aeiou)]aeiou}aeiou]aeiou}aeiou';
        Boolean result; 
        Boolean expected = true;         

        Test.startTest();
            result = CS_WidgetIsValueProperlyNested.checkValue(value);
        Test.stopTest();

        System.assertEquals(expected, result, 'Expected result is ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void unproperlyNestedTestOpenBracket() {

        String value = '(((';
        Boolean result; 
        Boolean expected = false;         

        Test.startTest();
            result = CS_WidgetIsValueProperlyNested.checkValue(value);
        Test.stopTest();

        System.assertEquals(expected, result, 'Expected result is ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void unproperlyNestedTestClosingBracket() {

        String value = '))';
        Boolean result; 
        Boolean expected = false;         

        Test.startTest();
            result = CS_WidgetIsValueProperlyNested.checkValue(value);
        Test.stopTest();

        System.assertEquals(expected, result, 'Expected result is ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void unproperlyNestedTest1() {

        String value = '{[()(){)[()]}]}';
        Boolean result; 
        Boolean expected = false;         

        Test.startTest();
            result = CS_WidgetIsValueProperlyNested.checkValue(value);
        Test.stopTest();

        System.assertEquals(expected, result, 'Expected result is ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void unproperlyNestedTest2() {

        String value = '{[()(){][()]}]}';
        Boolean result; 
        Boolean expected = false;         

        Test.startTest();
            result = CS_WidgetIsValueProperlyNested.checkValue(value);
        Test.stopTest();

        System.assertEquals(expected, result, 'Expected result is ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void unproperlyNestedTestMixWithText() {

        String value = 'as)[dsd[()fs]d]{sdfg)}{sdgf()})}dsf(}}{)()})';
        Boolean result; 
        Boolean expected = false;         

        Test.startTest();
            result = CS_WidgetIsValueProperlyNested.checkValue(value);
        Test.stopTest();

        System.assertEquals(expected, result, 'Expected result is ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void widgetRecordProperlyNestedTest() {

        String value = '{[()(){[()]}]}';
        Widget__c widget = dataFactory(value);
        Widget__c result = new Widget__c(); 
        Boolean expected = true;

        Test.startTest();
            CS_WidgetIsValueProperlyNested.CS_WidgetIsValueProperlyNested();
        Test.stopTest();

        result = [
            SELECT Id, CS_IsProperlyNested__c
            FROM Widget__c
            WHERE Id =: widget.Id
        ];

        System.assertEquals(expected, result.CS_IsProperlyNested__c, 'CS_IsProperlyNested__c value should be: ' +expected+ ' recived: '+ result);
    }

    @isTest
    public static void widgetRecordUnProperlyNestedTest() {

        String value = '{[()(){[(})]}]}';        
        Widget__c widget = dataFactory(value);
        Widget__c result = new Widget__c(); 
        Boolean expected = false;

        Test.startTest();
            CS_WidgetIsValueProperlyNested.CS_WidgetIsValueProperlyNested();
        Test.stopTest();

        result = [
            SELECT Id, CS_IsProperlyNested__c
            FROM Widget__c
            WHERE Id =: widget.Id
        ];

        System.assertEquals(expected, result.CS_IsProperlyNested__c, 'CS_IsProperlyNested__c value should be: ' +expected+ ' recived: '+ result);
    }
   
    @isTest
    public static void recordProperlyNestedTestIsCheckedTrue() {

        String value = '{[()(){[()]}]}';        
        Widget__c widget = dataFactory(value);
        Widget__c result = new Widget__c(); 
        Boolean expected = false;
        
        widget.CS_IsChecked__c = true;
        update widget;

        Test.startTest();
            CS_WidgetIsValueProperlyNested.CS_WidgetIsValueProperlyNested();
        Test.stopTest();

        result = [
            SELECT Id, CS_IsProperlyNested__c
            FROM Widget__c
            WHERE Id =: widget.Id
        ];

        System.assertEquals(expected, result.CS_IsProperlyNested__c, 'CS_IsProperlyNested__c value should be: ' +expected+ ' recived: '+ result);
    }  

    @isTest
    public static void flowCheckValueResponce() {

        String value = '{[()(){[()]}]}';
        List<String> valueList = new List<String>();
        List<Boolean> responceList = new List<Boolean>();
        Boolean expected = true; 
        valueList.add(value);        
        
        Test.startTest();
            responceList = CS_WidgetIsValueProperlyNested.flowCheckValue(valueList);
        Test.stopTest();

        System.assertEquals(1, responceList.size(), 'Responce should have 1 value recived: '+ responceList.size());
        System.assertEquals(expected, responceList[0], 'Responce should be ' +expected + 'value recived: '+ responceList[0]);
    }  
    
}