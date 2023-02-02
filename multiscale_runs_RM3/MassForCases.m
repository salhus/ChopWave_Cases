function Mass = MassForCases(caseID,rho)

if     caseID == 1
Mass.Float = rho* 7.258e-1; 
Mass.Spar  = rho* 8.867e-1;
end
if     caseID == 2
Mass.Float = rho* 5.807e+0; 
Mass.Spar  = rho* 7.093e+0;
end
if     caseID == 3
Mass.Float = rho* 4.645e+1; 
Mass.Spar  = rho* 5.675e+1;
end
if     caseID == 4
Mass.Float = rho* 4.645e+1; 
Mass.Spar  = rho* 5.675e+1;
end
if     caseID == 5
Mass.Float = rho* 9.073e+1; 
Mass.Spar  = rho* 1.108e+2;
end
if     caseID == 6
Mass.Float = rho* 1.568e+2; 
Mass.Spar  = rho* 1.915e+2;
end
if     caseID == 7
Mass.Float = rho* 2.490e+2; 
Mass.Spar  = rho* 371.626;
end
if     caseID == 8
Mass.Float = rho* 371.626; 
Mass.Spar  = rho* 453.983;
end
if     caseID == 9
Mass.Float = rho* 529.133; 
Mass.Spar  = rho* 646.396;
end
if     caseID == 10
Mass.Float = rho* 725.833; 
Mass.Spar  = rho* 886.687;
end




end