within DynTherM.Components.HeatTransfer;
model InternalConvectionFlux "Model of internal convection per unit area"

  replaceable package Medium = Modelica.Media.Air.MoistAir constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
  outer DynTherM.Components.Environment environment "Environmental properties";

  parameter Integer Nx=1 "Number of control volumes in x-direction";

  replaceable model HTC =
    DynTherM.Components.HeatTransfer.HTCorrelations.InternalConvection.FixedValue
    constrainedby
    DynTherM.Components.HeatTransfer.HTCorrelations.BaseClassInternal(
      Nx=Nx,
      Ny=1,
      ht_fixed=ones(Nx,1)) annotation (choicesAllMatching=true);

  HTC ht_correlation;

  DynTherM.CustomInterfaces.DistributedHeatFluxPort_A inlet(Nx=Nx, Ny=1) annotation (Placement(transformation(extent={{-38,-18},
            {38,58}}), iconTransformation(extent={{-38,-18},{38,58}})));
  DynTherM.CustomInterfaces.DistributedHeatFluxPort_B outlet(Nx=Nx, Ny=1) annotation (Placement(transformation(extent={{-38,-58},
            {38,18}}), iconTransformation(extent={{-38,-58},{38,18}})));

equation
  inlet.ports.phi + outlet.ports.phi = zeros(Nx,1);

  for i in 1:Nx loop
    inlet.ports[i,1].phi = ht_correlation.ht[i,1]*(inlet.ports[i,1].T - outlet.ports[i,1].T);
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{90,8},{-90,8}},     color={0,127,255}),
        Line(points={{78,-14},{90,-8}},    color={0,127,255}),
        Line(points={{90,-8},{-90,-8}},   color={0,127,255}),
        Line(points={{78,-2},{90,-8}},     color={0,127,255}),
        Line(points={{78,2},{90,8}},       color={0,127,255}),
        Line(points={{78,14},{90,8}},      color={0,127,255})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalConvectionFlux;
