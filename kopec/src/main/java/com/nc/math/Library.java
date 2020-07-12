package com.nc.math;


public class Library {

    public Library() {
    }

    public double min(double ad[]) {
        double d = ad[0];
        for(int i = 1; i < ad.length; i++)
            if(d > ad[i])
                d = ad[i]; 

        return d;
    }

    public double max(double ad[]) {
        double d = ad[0];
        for(int i = 1; i < ad.length; i++)
            if(d < ad[i])
                d = ad[i];

        return d;
    }

    public double average(double ad[]){
        double d = 0.0D;
        for(int i = 0; i < ad.length; i++)
            d += ad[i];

        return d / (double)ad.length;
    }

    public double valueOf(Object aobj[]) {
        int i = 0;
        double d = 0.0D;
        for(; i < aobj.length; i++)
            try {
                d += Double.valueOf(aobj[i].toString().trim()).doubleValue();
            } catch(NumberFormatException numberformatexception) { 
            } catch(Exception exception) { }

        return d;
    }

    public double sum(double ad[]) {
        double d = 0.0D;
        for(int i = 0; i < ad.length; i++)
            d += ad[i];

        return d;
    }

    public double product(double ad[]) {
        double d = 1.0D;
        for(int i = 0; i < ad.length; i++)
            d *= ad[i];

        return d;
    }

    public double random() {
        return Math.random();
    }
}
