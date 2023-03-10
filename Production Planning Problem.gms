set
         t period /1*6/
parameters
         I0      initial inventory                                    /150/
         N       number of initial work force                        /30/
         Tt      normal production time each month                  /175/
         W0      initial person-hour                               /5250/
         Cv      cost of maintenance of each remaining product    /750000/
         Cr      cost of each person-hour for normaltime work    /17500/
         Co      cost of each person-hour for overtime work     /24000/
         Ch      cost of recruitment of each new work force    /600000/
         PT      needed person-hour for producing each product/7/
         C       cost of producing each product              /8500000/
         P       allowable percentage of overtime work      /0.25/
         D(t)    demand of product each month              /1 750,2 600,3 540,4 500, 5 540, 6 590/;
variable
         Z;
positive variables
         X(t),I(t),W(t),H(t),O(t);
equations
objectivefunction
Co1
Co2(t)
Co3
Co4(t)
Co5(t)
Co6(t);

objectivefunction        ..Z=e=sum(t,(c*X(t)+Cv*I(t)+Cr*W(t)+Co*O(t)+Ch*H(t)));
Co1                      ..I0+X('1')-I('1')=e=D('1');
Co2(t)$(ord(t)>1)        ..I(t-1)+X(t)-I(t)=e=D(t);
Co3                      ..W('1')=e=W0+H('1')*Tt;
Co4(t)$(ord(t)>1)        ..W(t)=e=W(t-1)+H(t)*Tt;
Co5(t)                   ..PT*X(t)=l=W(t)+O(t);
Co6(t)                   ..O(t)=l=P*W(t);

model SecondQuestionmodel /all/;
option  limcol=10 , limrow=10;
solve SecondQuestionmodel using lp minimizing Z;
display z.l,X.l,I.l,H.l,W.l,O.l;
