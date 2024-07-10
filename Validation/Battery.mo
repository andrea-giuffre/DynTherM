within DynTherM.Validation;
package Battery
  model PouchCellPolestar
    package Water = Modelica.Media.Water.StandardWater;
    Components.Battery.PouchCell1D pouchCell1D(
      H=0.1,
      W=0.35,
      t=0.01,
      C_nom(displayUnit="Ah") = 230400,
      initOpt=environment.initOpt,
      SoC_start=0.1,
      Tstart=298.15)
      annotation (Placement(transformation(extent={{-22,26},{54,76}})));
    Modelica.Blocks.Sources.TimeTable I_charging(table=[0,200; 200,200; 200,200; 500,
          200; 501,120; 700,120; 701,100; 900,100; 901,120; 1000,120; 1001,70; 1200,
          70]) annotation (Placement(transformation(extent={{98,52},{82,68}})));
    Components.OneDimensional.CircularCV single_channel(
      redeclare model Mat = DynTherM.Materials.Aluminium,
      redeclare package Medium = Water,
      allowFlowReversal=environment.allowFlowReversal,
      initOpt=environment.initOpt,
      L=0.3,
      R_ext(displayUnit="mm") = 0.0051,
      R_int(displayUnit="mm") = 0.005,
      T_start_solid=298.15,
      T_start_fluid=298.15,
      m_flow_start=0.044,
      u_start=1)
      annotation (Placement(transformation(extent={{-6,-66},{46,-14}})));
    BoundaryConditions.flow_source flow_source(
      redeclare package Medium = Water,
      T_nom=298.15,
      massFlow_nom=0.04,
      allowFlowReversal=environment.allowFlowReversal,
      use_in_massFlow=true,
      use_in_T=true)
      annotation (Placement(transformation(extent={{-62,-52},{-38,-28}})));
    BoundaryConditions.pressure_sink pressure_sink(redeclare package Medium =
          Water,                              allowFlowReversal=environment.allowFlowReversal)
      annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
    Modelica.Blocks.Sources.Ramp m_cool(
      height=0.00004,
      duration=12,
      offset=0.04416,
      startTime=20)
      annotation (Placement(transformation(extent={{-88,-28},{-72,-12}})));
    Modelica.Blocks.Sources.Constant T_cool(k=298.15)
      annotation (Placement(transformation(extent={{-88,12},{-72,28}})));
    inner Components.Environment environment(allowFlowReversal=false, initOpt=
          DynTherM.Choices.InitOpt.fixedState)
      annotation (Placement(transformation(extent={{-98,40},{-64,74}})));
  equation
    connect(flow_source.outlet, single_channel.inlet)
      annotation (Line(points={{-38,-40},{-0.8,-40}}, color={0,0,0}));
    connect(single_channel.outlet, pressure_sink.inlet)
      annotation (Line(points={{40.8,-40},{70,-40}}, color={0,0,0}));
    connect(single_channel.solid_surface, pouchCell1D.Bottom)
      annotation (Line(points={{20,-19.2},{20,31},{20.2222,31}},
                                                      color={191,0,0}));
    connect(m_cool.y, flow_source.in_massFlow) annotation (Line(points={{-71.2,-20},
            {-59.6,-20},{-59.6,-31.6}}, color={0,0,127}));
    connect(T_cool.y, flow_source.in_T) annotation (Line(points={{-71.2,20},{-52.4,
            20},{-52.4,-31.6}}, color={0,0,127}));
    connect(I_charging.y, pouchCell1D.I) annotation (Line(points={{81.2,60},{54,
            60},{54,59.3333},{53.1556,59.3333}},
                                             color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
              {100,80}})),                                         Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,80}})),
      experiment(
        StopTime=1200,
        Interval=1,
        __Dymola_Algorithm="Dassl"));
  end PouchCellPolestar;

end Battery;
