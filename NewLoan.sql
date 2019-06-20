DECLARE

    p           number:=3133300.00;     -- principal amout
    n           number:=20     ;     -- payament period in years
    r           number:=9.25   ;     -- rate of interest yearly
    ins         number:=0.00      ;     -- monthly installment
    pins        number:=0.00      ;     -- monthly principal paid
    iins        number:=0.00      ;     -- monthly interest paid
    ins1        number:=0.00      ;     -- interest of first month
    dateofloan  date :=to_date('01/10/2009','dd/mm/yyyy');
    New_EMI     NUMBER:=0.00;
    NEW_ROI     NUMBER:=0.00;
    PRE_PAID_PRINC   NUMBER:=0.00;
    NEW_DATE    date;
BEGIN

---- Calculating rate of interest for period 
dbms_output.put_line('==================================================== ');
dbms_output.put_line('Total Loan Amount    p     : '||p);
dbms_output.put_line('Rate of Interest(Yearly) r  : '||r);
r:=round(r/1200,8);
dbms_output.put_line('Applied Rate of Interest r per month : '||r);
----- Calculating period 
dbms_output.put_line('Periods (Years)       n    : '||n);
n:=n*12;
dbms_output.put_line('Total Installments     months   : '||n);
------ Calculating monthly installment 
ins:=round((p*r*power((1+r),240))/(power((1+r),240)-1),0);
dbms_output.put_line('ins  : '||ins);
ins1:=round (p*r,0);
dbms_output.put_line('ins1  : '||ins1);

dbms_output.put_line('Monthly Insatllment       : '||round(ins,0));
dbms_output.put_line('==================================================== ');
dbms_output.put_line('***********  Amortization Schedule  **************** ');
dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------------');
dbms_output.put_line('Date       '||' | Amount for cal    |'||' Installment   |'||' Interst paid    |'||' Principal Paid  |'||' Outstanding Amount till date ');
dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------------');

For i in 1..n
loop

   IF  New_EMI =0.00 AND NEW_ROI = 0.00 AND PRE_PAID_PRINC = 0.00 then

dbms_output.put_line(add_months(to_date(dateofloan,'dd/mm/yyyy'),i-1)||' |'||rtrim(p,12)||'            '||'|'||ins||'       |'||ins1||'         |'||(ins-ins1)||'          |'         ||(p-ins+ins1));
p:=p-ins+ins1;
ins1:=round (p*r,0);
end if;
end loop;
dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------------');
EXCEPTION

when others then
dbms_output.put_line('Error : '||SQLERRM);

END;

