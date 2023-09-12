within ThermalManagement.Components.MassTransfer;
model Mixer "Mixer of two streams with adiabatic walls (no heat transfer)"
  package Medium = Modelica.Media.Air.MoistAir;
  parameter Modelica.Units.SI.Volume V "Inner volume";
  parameter Boolean allowFlowReversal=environment.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermalManagement.Components.Environment environment "Environmental properties";
  parameter Medium.AbsolutePressure P_start=101325 "Pressure start value" annotation (Dialog(tab="Initialization"));
  parameter Medium.Temperature T_start=300 "Temperature start value" annotation (Dialog(tab="Initialization"));
  parameter Medium.MassFraction X_start[2]={0,1} "Start gas composition" annotation (Dialog(tab="Initialization"));
  parameter ThermalManagement.Choices.InitOpt initOpt=environment.initOpt
    "Initialization option" annotation (Dialog(tab="Initialization"));
  parameter Boolean noInitialPressure=false "Remove initial equation on pressure" annotation (Dialog(tab="Initialization"),choices(checkBox=true));
  parameter Boolean noInitialTemperature=false "Remove initial equation on temperature" annotation (Dialog(tab="Initialization"),choices(checkBox=true));

  Modelica.Units.SI.Mass M "Total mass";
  Modelica.Units.SI.InternalEnergy E "Total internal energy";
  Medium.AbsolutePressure P(start=P_start) "Pressure";
  Medium.Temperature T(start=T_start) "Temperature";
  Medium.MassFraction X[2](start=X_start) "Mass fractions";
  Real phi "Relative humidity";
  Medium.ThermodynamicState state "Thermodynamic state";
  Modelica.Units.SI.Time Tr "Residence Time";

  ThermalManagement.CustomInterfaces.FluidPort_A inlet1(m_flow(min=if
          allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
      Placement(transformation(extent={{-120,-60},{-80,-20}},
                                                            rotation=0),
        iconTransformation(extent={{-90,-50},{-70,-30}})));
  ThermalManagement.CustomInterfaces.FluidPort_B outlet(m_flow(max=if
          allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
      Placement(transformation(extent={{80,-20},{120,20}}, rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));

  CustomInterfaces.FluidPort_A inlet2(m_flow(min=if allowFlowReversal then -
          Modelica.Constants.inf else 0)) annotation (Placement(
        transformation(extent={{-120,20},{-80,60}}, rotation=0),
        iconTransformation(extent={{-90,30},{-70,50}})));
equation
  state = Medium.setState_pTX(P, T, X);
  phi = Medium.relativeHumidity(state);

  // Conservation equations
  M = Medium.density(state)*V "Gas mass";
  E = M*Medium.specificInternalEnergy(state) "Gas internal energy";
  der(M) = inlet1.m_flow + inlet2.m_flow + outlet.m_flow "Mass balance";
  der(E) = inlet1.m_flow*actualStream(inlet1.h_outflow) +
    inlet2.m_flow*actualStream(inlet2.h_outflow) +
    outlet.m_flow*actualStream(outlet.h_outflow) "Energy balance";
  for j in 1:2 loop
    M*der(X[j]) = inlet1.m_flow*(actualStream(inlet1.Xi_outflow[j]) - X[j]) +
      inlet2.m_flow*(actualStream(inlet2.Xi_outflow[j]) - X[j]) +
      outlet.m_flow*(actualStream(outlet.Xi_outflow[j]) - X[j])
      "Independent component mass balance";
  end for;

  // Boundary conditions
  inlet1.P = P;
  inlet1.h_outflow = Medium.specificEnthalpy(state);
  inlet1.Xi_outflow = X;
  inlet2.P = P;
  inlet2.h_outflow = Medium.specificEnthalpy(state);
  inlet2.Xi_outflow = X;
  outlet.P = P;
  outlet.h_outflow = Medium.specificEnthalpy(state);
  outlet.Xi_outflow = X;

  Tr = noEvent(M/max(abs(-outlet.m_flow), Modelica.Constants.eps))
    "Residence time";

initial equation
  // Initial conditions
  if initOpt == ThermalManagement.Choices.InitOpt.noInit then
    // do nothing
  elseif initOpt == ThermalManagement.Choices.InitOpt.fixedState then
    if not noInitialPressure then
      P = P_start;
    end if;
    if not noInitialTemperature then
      T = T_start;
    end if;
    X = X_start;
  elseif initOpt == ThermalManagement.Choices.InitOpt.steadyState then
    if not noInitialPressure then
      der(P) = 0;
    end if;
    if not noInitialTemperature then
      der(T) = 0;
    end if;
    der(X) = zeros(2);
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Documentation(info="<html>
<p>This model describes a rigid, adiabatic control volume.
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt> .
</html>",
        revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Icon(graphics={          Ellipse(
          extent={{-90,-90},{90,90}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}));
end Mixer;
