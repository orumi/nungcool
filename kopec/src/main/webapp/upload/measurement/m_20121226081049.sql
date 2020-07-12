
select * from
(
    select v.cname,v.sname,v.bname,v.pname,v.oname,v.mname,d.id,d.weight,d.unit,
    d.planned,d.base,d.limit,d.frequency,d.eval_frq,d.equation,d.equationdefine,
    d.etlkey,d.measurement,d.trend,d.evalmethod
    from view_hierarchy v, tblmeasuredefine d where v.mcid=d.id and v.year=2012
) a
left join
(
    select measureid,strdate,planned,base,limit,actual,score from tblmeasurescore where strdate like '201209%'
) b
on
a.id=b.measureid
