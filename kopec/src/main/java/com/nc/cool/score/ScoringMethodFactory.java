package com.nc.cool.score;

public class ScoringMethodFactory
{

    public ScoringMethodFactory(){
    }

    public static ScoringMethod getScoringMethod() throws Exception {
        
        Object obj = new BackwardEffectScoring();
        
        ((ScoringMethod) (obj)).setFrequency(3);
        
        return ((ScoringMethod) (obj));
    }
}
