package exam;

import static org.junit.Assert.*;
import junit.textui.TestRunner;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;


public class SynchroTest {

    @Test
    public void test() throws Exception{
    	MyThread1 t1=new MyThread1();  
    	t1.start(); 
    	MyThread2 t2=new MyThread2();  
    	t2.start(); 
    	MyThread3 t3=new MyThread3();  
    	t3.start(); 
    	
    	
    	Thread.sleep(30000);
    	try {
			System.out.println("end");
		} catch (Exception e) {
			// TODO: handle exception
		}
    }

}


class Table{  
	synchronized static void printTable(int n){  
		for(int i=1;i<=10;i++){  
			System.out.println(n*i);  
		    try{  
		    	Thread.sleep(400);  
		    }catch(Exception e){}  
		 }
	}
}

class MyThread1 extends Thread{  
	public void run(){  
		Table.printTable(1);  
	}  
}

class MyThread2 extends Thread{  
	public void run(){  
		Table.printTable(10);  
	}  
}

class MyThread3 extends Thread{  
	public void run(){  
		Table.printTable(100);  
	}  
}