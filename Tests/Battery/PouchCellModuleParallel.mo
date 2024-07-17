within DynTherM.Tests.Battery;
model PouchCellModuleParallel

  parameter Integer N_cv=10;
  parameter Length W_cell=0.35;
  parameter Length H_cell=0.1;
  parameter Length t_cell=0.01;
  parameter Length t_fw=0.001;
  parameter ElectricCharge C_nom=230400;
  parameter Real SoC_start=0.1;
  parameter Temperature Tstart=298.15;

  Modelica.Blocks.Sources.TimeTable I_charging(table=[0,200; 200,200; 200,200; 500,
        200; 501,120; 700,120; 701,100; 900,100; 901,120; 1000,120; 1001,70; 1200,
        70]) annotation (Placement(transformation(extent={{78,62},{62,78}})));
  inner Components.Environment environment(allowFlowReversal=false, initOpt=
        DynTherM.Choices.InitOpt.fixedState)
    annotation (Placement(transformation(extent={{80,20},{114,54}})));
  Components.Electrical.PouchCell1D cell_right(
    H=H_cell,
    W=W_cell,
    t=t_cell,
    C_nom(displayUnit="Ah") = C_nom,
    initOpt=environment.initOpt,
    SoC_start=SoC_start,
    Tstart=Tstart,
    N=N_cv) annotation (Placement(transformation(extent={{24,-72},{96,-24}})));
  Components.Electrical.PouchCell1D cell_left(
    H=H_cell,
    W=W_cell,
    t=t_cell,
    C_nom(displayUnit="Ah") = C_nom,
    initOpt=environment.initOpt,
    SoC_start=SoC_start,
    Tstart=Tstart,
    N=N_cv) annotation (Placement(transformation(extent={{-64,-70},{8,-22}})));
  Components.OneDimensional.WallConduction1D firewall(
    redeclare model Mat = DynTherM.Materials.PolyurethaneFoam,
    t=t_fw,
    A=W_cell*H_cell,
    Tstart=298.15,
    initOpt=environment.initOpt,
    N=N_cv)                                           annotation (Placement(
        transformation(
        extent={{-18,-14},{18,14}},
        rotation=-90,
        origin={18,-48})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrentScalar
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={20,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-88,-36},{-72,-20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrentVector
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-40,54})));
  Systems.Battery.PouchModuleFirewall module(
    W_cell=W_cell,
    H_cell=H_cell,
    t_cell(displayUnit="mm") = t_cell,
    t_fw(displayUnit="mm") = t_fw,
    t_gap=t_fw,
    C_nom(displayUnit="Ah") = C_nom,
    initOpt=environment.initOpt,
    SoC_start=SoC_start,
    Tstart=Tstart,
    N_cv=N_cv,
    Ns=1,
    Np=2)
    annotation (Placement(transformation(extent={{-68,-10},{0,56}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{46,64},{34,76}})));
equation
  connect(firewall.inlet, cell_right.Left) annotation (Line(points={{22.2,-48},{
          38.8,-48}},                               color={191,0,0}));
  connect(cell_left.Right, firewall.outlet) annotation (Line(points={{-6,-46},{-6,
          -48},{13.8,-48}},                         color={191,0,0}));
  connect(cell_left.p, cell_right.p) annotation (Line(points={{0.4,-38.4},{0.4,-20},
          {88.4,-20},{88.4,-40.4}},            color={0,0,255}));
  connect(cell_left.n, cell_right.n) annotation (Line(points={{0.4,-54.4},{0.4,-74},
          {88.4,-74},{88.4,-56.4}},            color={0,0,255}));
  connect(signalCurrentScalar.n, cell_right.n) annotation (Line(points={{26,0},{
          100,0},{100,-56.4},{88.4,-56.4}},color={0,0,255}));
  connect(cell_left.p, ground.p) annotation (Line(points={{0.4,-38.4},{0.4,-20},
          {-80,-20}},  color={0,0,255}));
  connect(module.p, signalCurrentVector.p) annotation (Line(points={{-54.4,16.4},
          {-54.4,54},{-46,54}}, color={0,0,255}));
  connect(signalCurrentVector.n, module.n) annotation (Line(points={{-34,54},{-27.2,
          54},{-27.2,16.4}}, color={0,0,255}));
  connect(module.p, ground.p) annotation (Line(points={{-54.4,16.4},{-80,16.4},{
          -80,-20}}, color={0,0,255}));
  connect(gain.u, I_charging.y)
    annotation (Line(points={{47.2,70},{61.2,70}}, color={0,0,127}));
  connect(gain.y, signalCurrentScalar.i)
    annotation (Line(points={{33.4,70},{20,70},{20,7.2}}, color={0,0,127}));
  connect(gain.y, signalCurrentVector.i)
    annotation (Line(points={{33.4,70},{-40,70},{-40,61.2}}, color={0,0,127}));
  connect(cell_left.p, signalCurrentScalar.p)
    annotation (Line(points={{0.4,-38.4},{0.4,0},{14,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -80},{120,80}})),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{120,
            80}})),
    experiment(
      StopTime=1200,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end PouchCellModuleParallel;
