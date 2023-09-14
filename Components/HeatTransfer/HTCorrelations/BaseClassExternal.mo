within DynTherM.Components.HeatTransfer.HTCorrelations;
partial model BaseClassExternal
  replaceable package Medium = Modelica.Media.Air.MoistAir constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
  outer DynTherM.Components.Environment environment "Environmental properties";
  input Modelica.Units.SI.Temperature T_skin
    "Fuselage outer skin temperature";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer ht_start=10
    "Heat transfer coefficient - starting value";
  Modelica.Units.SI.CoefficientOfHeatTransfer ht(start=ht_start)
    "Heat transfer coefficient";
  Modelica.Units.SI.Temperature T_out
    "Temperature used to compute heat flow rate";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseClassExternal;
