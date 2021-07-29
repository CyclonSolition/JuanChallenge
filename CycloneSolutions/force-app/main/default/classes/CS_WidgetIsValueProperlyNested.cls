public class CS_WidgetIsValueProperlyNested implements Schedulable{
    
    public void execute(SchedulableContext SC) {
        CS_WidgetIsValueProperlyNested();
         
    }

    public static void CS_WidgetIsValueProperlyNested() {
        
        List<Widget__c> widgetList = [
            SELECT id, CS_Value__c, CS_IsProperlyNested__c
            FROM Widget__c
            WHERE CS_IsChecked__c = false
        ]; 

        if (!widgetList.IsEmpty()) {
            for (Widget__c widget : widgetList) {

                widget.CS_IsChecked__c = true;

                widget.CS_IsProperlyNested__c = checkValue(widget.CS_Value__c);
            }
            
            update widgetList;
        }

    }

    //Method check if string is properly nested
    public static Boolean checkValue(String value){
        
        Set<String> bracketsControl = new Set<String>{'(',')','{','}','[',']'};
        List<String> brackets = new List<String>();
        
        if (!String.isEmpty(value)) {
            
            //loop each char in the string
            for (Integer i = 0; i < value.length(); i++) {                
               
                String charact = value.substring(i,i+1);
                
                //check if the element is a bracket
                if (!bracketsControl.contains(charact)) {
                    continue; 
                }
                
                
                //check if the charact is a open bracket
                if (charact == '(' || charact == '[' || charact == '{'){
                    
                    // Add the element in the brackets
                    brackets.add(charact);
                    continue;               
                }
    
                // if the previous elements arent open brackets automatically 
                //is not propertly nested
                if (brackets.size()==0){
    
                    return false;
                }
    
                //Check on close brackets and last added bracked to the opening brackets
                String lastBracket;
                if( charact == ')'){
    
                    lastBracket = brackets.remove(brackets.size()-1);
    
                    if (lastBracket == '{' || lastBracket == '['){
                       return false;
                    }                    
                }else if( charact == '}'){
    
                    lastBracket = brackets.remove(brackets.size()-1);
    
                    if (lastBracket == '(' || lastBracket == '['){
                        return false;
                    }
                }else if( charact == ']'){
    
                    lastBracket = brackets.remove(brackets.size()-1);
                    
                    if (lastBracket == '(' || lastBracket == '{'){
                        return false;
                    }
                }
            }
        }
        
        return (brackets.size()==0);
    }

    //Method to be call by flow 'WidgetInputScreen' (Only recive and acpts)
    @InvocableMethod
    public static List<Boolean> flowCheckValue(List<String> valueList){
        List<Boolean> checkValueResponce = new List<Boolean>();
        Boolean responce;
        for (String value : valueList) {
            responce = checkValue(value);
            checkValueResponce.add(responce);                     
        }
        return checkValueResponce;
    }

}