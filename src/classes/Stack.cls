public class Stack {
    static List<String> l= new List<String>();
    public static void push(String a)
    {
        l.add(a);
        System.debug('Added element: '+ a );
    }
    public static void pop()
    {
        integer count= l.size();
        integer index= count-1;
        String element= l.get(index);
        l.remove(index);
        System.debug('Element removed: '+ element);
    }
    public static void peep()
    {
        integer count= l.size()-1;
        for(integer i=count;i>=0;i--)
        {
            System.debug(l.get(i));
        }
        
    }
}