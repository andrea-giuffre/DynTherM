within DynTherM.BoundaryConditions;
model thermal_distributed
  "Model to impose distributed heat flow rate and temperature"

  parameter Integer N(min=1) "Number of ports";
  input Modelica.Units.SI.Temperature T[N]=273.15*ones(N) "Temperature" annotation (Dialog(tab="Boundary conditions", enable=use_T));
  input Modelica.Units.SI.HeatFlowRate Q[N]=1e3*ones(N) "Heat flow rate" annotation (Dialog(tab="Boundary conditions", enable=use_Q));
  parameter Boolean use_Q = true "True if heat flow rate is given"  annotation (Dialog(tab="Boundary conditions"));
  parameter Boolean use_T = false "True if temperature is given" annotation (Dialog(tab="Boundary conditions"));

  CustomInterfaces.DistributedHeatPort_A thermal(N=N) annotation (Placement(
        transformation(extent={{74,-16},{106,16}}), iconTransformation(extent={{
            74,-16},{106,16}})));
equation
  //Boundary equations
  if use_T then
    thermal.ports.T = T;
  end if;

  if use_Q then
    thermal.ports.Q_flow + Q = zeros(N);
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{60,-20},
            {120,20}})),                  Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{60,-20},{120,20}}),     graphics={Text(
          extent={{86,8},{94,0}},
          lineColor={238,46,47},
          textString="thermal distributed")}));
end thermal_distributed;
