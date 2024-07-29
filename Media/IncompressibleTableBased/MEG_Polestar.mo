within DynTherM.Media.IncompressibleTableBased;
package MEG_Polestar "Coolant Used in Polestar battery Module"

  constant Real X;

  // ------------------------------------- TABULATED DENSITY -------------------------------------
  constant Real[33,2] table_Density = [233.15,1103.370994;
238.15,1100.941843;
243.15,1098.495779;
248.15,1096.030031;
253.15,1093.541825;
258.15,1091.028392;
263.15,1088.486958;
268.15,1085.914751;
273.15,1083.309;
278.15,1080.666933;
283.15,1077.985777;
288.15,1075.262761;
293.15,1072.495113;
298.15,1069.680061;
303.15,1066.814833;
308.15,1063.896656;
313.15,1060.92276;
318.15,1057.890372;
323.15,1054.79672;
328.15,1051.639032;
333.15,1048.414536;
338.15,1045.120461;
343.15,1041.754034;
348.15,1038.312484;
353.15,1034.793038;
358.15,1031.192925;
363.15,1027.509372;
368.15,1023.739608;
373.15,1019.88086;
378.15,1015.930357;
383.15,1011.885327;
388.15,1007.742998;
393.15,1003.500598];

  // ------------------------------ TABULATED SPECIFIC HEAT CAPACITY -----------------------------
  constant Real[33,2] table_HeatCapacity = [233.15,2859.908434;
238.15,2904.081738;
243.15,2947.065973;
248.15,2988.861137;
253.15,3029.46723;
258.15,3068.884253;
263.15,3107.112206;
268.15,3144.151088;
273.15,3180.0009;
278.15,3214.661641;
283.15,3248.133312;
288.15,3280.415912;
293.15,3311.509442;
298.15,3341.413902;
303.15,3370.129291;
308.15,3397.655609;
313.15,3423.992858;
318.15,3449.141035;
323.15,3473.100143;
328.15,3495.870179;
333.15,3517.451146;
338.15,3537.843041;
343.15,3557.045867;
348.15,3575.059622;
353.15,3591.884306;
358.15,3607.51992;
363.15,3621.966464;
368.15,3635.223937;
373.15,3647.29234;
378.15,3658.171672;
383.15,3667.861934;
388.15,3676.363125;
393.15,3683.675246];

  // ------------------------------- TABULATED THERMAL CONDUCTIVITY ------------------------------
  constant Real[33,2] table_Conductivity = [233.15,0.353494905;
238.15,0.35666617;
243.15,0.359836307;
248.15,0.363005316;
253.15,0.366173196;
258.15,0.369339947;
263.15,0.37250557;
268.15,0.375670064;
273.15,0.37883343;
278.15,0.381995667;
283.15,0.385156776;
288.15,0.388316756;
293.15,0.391475608;
298.15,0.394633331;
303.15,0.397789925;
308.15,0.400945391;
313.15,0.404099729;
318.15,0.407252937;
323.15,0.410405018;
328.15,0.41355597;
333.15,0.416705793;
338.15,0.419854487;
343.15,0.423002054;
348.15,0.426148491;
353.15,0.4292938;
358.15,0.432437981;
363.15,0.435581033;
368.15,0.438722956;
373.15,0.441863751;
378.15,0.445003417;
383.15,0.448141955;
388.15,0.451279364;
393.15,0.454415645];

  // --------------------------------- TABULATED DYNAMIC VISCOSITY -------------------------------
  constant Real[33,2] table_Viscosity = [233.15, 0.185786127;
                                               238.15, 0.101223622;
                                               243.15, 0.061852504;
                                               248.15, 0.040867917;
                                               253.15, 0.028578754;
                                               258.15, 0.020864123;
                                               263.15, 0.015755504;
                                               268.15, 0.012226186;
                                               273.15, 0.009702511;
                                               278.15, 0.007845667;
                                               283.15, 0.006446191;
                                               288.15, 0.005369525;
                                               293.15, 0.004526365;
                                               298.15, 0.003855753;
                                               303.15, 0.003315046;
                                               308.15, 0.002873768;
                                               313.15, 0.002509716;
                                               318.15, 0.002206442;
                                               323.15, 0.001951567;
                                               328.15, 0.001735652;
                                               333.15, 0.001551404;
                                               338.15, 0.001393128;
                                               343.15, 0.001256327;
                                               348.15, 0.001137417;
                                               353.15, 0.001033516;
                                               358.15, 0.000942287;
                                               363.15, 0.000861823;
                                               368.15, 0.000790553;
                                               373.15, 0.000727179;
                                               378.15, 0.000670615;
                                               383.15, 0.000619957;
                                               388.15, 0.000574438;
                                               393.15, 0.000533411];

  extends Modelica.Media.Incompressible.TableBased(
    mediumName="Ethylene Glycol-Water",
    TinK = true,
    T_min=233.15,
    T_max=393.15,
    tableDensity=table_Density,
    tableHeatCapacity=table_HeatCapacity,
    tableConductivity=table_Conductivity,
    tableViscosity=table_Viscosity);

    annotation (Documentation(info="<html>
<p>Tabulated&nbsp;thermo-physical&nbsp;properties&nbsp;computed&nbsp;with&nbsp;REFPROP</p>
</html>"));
end MEG_Polestar;
