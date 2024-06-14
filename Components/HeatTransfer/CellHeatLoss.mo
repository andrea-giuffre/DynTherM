within DynTherM.Components.HeatTransfer;
model CellHeatLoss "Model of heat generation due to reversible and irreversible loss within a cell"

  // Electrical parameters
  parameter Real eta = 0.98 "Charging/discharging efficiency";
  parameter ElectricCharge capacity = 216000 "Cell capacity";
  parameter Real SoC_min = 0.00 "Minimum allowable state of charge";
  parameter Real SoC_max = 1.00 "Maximum allowable state of charge";

  // Initialization
  parameter Choices.InitOpt initOpt=Choices.InitOpt.fixedState
    "Initialization option" annotation (Dialog(tab="Initialization"));
  parameter Real SoC_start "Starting state of charge" annotation (Dialog(tab="Initialization"));

  Components.Battery.EquivalentCircuitModel.ElectricalCircuit ECM_1RC(
    eta=eta,
    capacity=capacity,
    SoC_min=SoC_min,
    SoC_max=SoC_max,
    initOpt=initOpt,
    SoC_start=SoC_start)
    annotation (Placement(transformation(extent={{-6,-54},{136,64}})));
  Components.Battery.EquivalentCircuitModel.ParametersInterpolation Parameters_1RC
    annotation (Placement(transformation(extent={{-110,-50},{-10,50}})));

  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
          extent={{-158,-32},{-134,-8}}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-14,66})));
  Modelica.Blocks.Interfaces.RealInput I annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={144,-2}), iconTransformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={12,66})));
  Modelica.Blocks.Interfaces.RealOutput Q annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={1.77636e-15,-76}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={0,-66})));

equation
  Q = ECM_1RC.Q_irrev + I*T*Parameters_1RC.Entropic_coeff;

  connect(Parameters_1RC.V_ocv, ECM_1RC.V_ocv) annotation (Line(points={{-10,0},
          {10.875,0},{10.875,0.28},{11.75,0.28}}, color={0,0,127}));
  connect(Parameters_1RC.R0, ECM_1RC.R0) annotation (Line(points={{-10,20},{10,20},
          {10,50},{40.15,50},{40.15,34.5}}, color={0,0,127}));
  connect(Parameters_1RC.R1, ECM_1RC.R1) annotation (Line(points={{-10,-20},{0,-20},
          {0,60},{75.65,60},{75.65,46.3}}, color={0,0,127}));
  connect(Parameters_1RC.C1, ECM_1RC.C1) annotation (Line(points={{-10,-40},{0,
          -40},{0,-50},{74.4667,-50},{74.4667,5}},  color={0,0,127}));
  connect(ECM_1RC.SoC, Parameters_1RC.SoC) annotation (Line(points={{112.333,
          40.4},{130,40.4},{130,72},{-130,72},{-130,20},{-110,20}},
                                                              color={0,0,127}));
  connect(Parameters_1RC.T, T)
    annotation (Line(points={{-110,-20},{-146,-20}}, color={0,0,127}));
  connect(ECM_1RC.I, I) annotation (Line(points={{118.25,-2.08},{120,-2.08},{120,
          -2},{144,-2}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-80},{140,80}}),
                        graphics={Bitmap(
          extent={{-60,-60},{60,60}},
          rotation=180,
          imageSource="iVBORw0KGgoAAAANSUhEUgAAAZ8AAAIACAMAAABq5JGtAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAMAUExURf///wAAAAgAAPf39ykpIe/v5ubm5hAQCCEhIc7W1jExMRkQGd7e3lJKUs7FzpyUnLWttcXFvXt7hLW1vYSMjEJCOjE6MWNaWq2trUpKSmtzc3t7e1JaUqWlpZSUlGtrY96l5qUZpUIZpd6ltXMZpRAZpaUZe0IZe3MZexAZe6UZzkIZznMZzhAZzqWEY6UZ70IZ70K1WkK1GXMZ7xAZ7xC1WhC1GUKUWkKUGRCUWhCUGa2EvaVSOq1SvXNSOoSEvaVSEIRSvXNSEIxSY63mzq3OnIy1zoTmzoTOnBBSYxlSEFLm70Lma1KE70LmKVLmrVKErRnm7xmE7xnmrRmEraW1a6W1KRApSlK17xDma1JS7xDmKVK1rVJSrRm17xlS7xm1rRlSrXO1a3O1KVLmzkLmSlKEzkLmCFLmjFKEjBnmzhmEzhnmjBmEjKW1SqW1CBAISlK1zhDmSlJSzhDmCFK1jFJSjBm1zhlSzhm1jBlSjHO1SnO1CK0ZUu9ajO9aOmsZUu8ZjO8ZOu+cjO+cOu/Fva0ZKe9aY+9aEGsZKe8ZY+8ZEO+cY++cEIwZUs5ajM5aOkoZUs4ZjM4ZOs6cjM6cOowZKc5aY85aEEoZKc4ZY84ZEM6cY86cEK2E76WEOq1S73OEOoSE76WEEIRS73OEEEprEKVSlKXma+9C5qXmKe8Q5q1SY3Pma+9CtXPmKe8Qte9z5u9ztaXmSs5C5qXmCM4Q5nPmSs5CtXPmCM4Qtc5z5s5zta3m7+/ejK3vnO/eOoy174Tm74TvnO/mve/eY+/eEHtalBBzYxlSMTFSYxlzEM7ejM7eOs7eY87eEIStnN7/va0ZCEprMaVzlFoZCIQZCDEZCDFzYxlzMbW15kpKGdbO787mtTEQSlJra/fO797/Wt7/Ga2UlGuEWnuEY87v7wgpIRApCGtSc1JKazEQIVJzUrWtlAgIIXt7lM7m1gAhCO/m3hAACDExSqWtjDE6Uubv9yExIZyUjN7///fv9/f35gAACAgAEAAAAPe2KREAAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAAA7DAAAOwwHHb6hkAABLU0lEQVR4Xu1dbXPayNKFIhgbE+wYs7EDif//r9oPt7aS8lP7wXFq2S0o13N6XrrPoAEkLGFMdO7dXVmARur37ukZdX5r9MN/WxwnRhfhoMVRon/VatBR4+4qHLQ4Slw8jFondMz43CrQUeNu2KrPMaN//jUctThKzH+1CnTMuBpMwlGLY0S/+9ALhy2OEcPzUThqcXSA6sy63+Q/LfbBqHnZvutO20Lp3rhrnEGjp+4Y/1n4v1pUw/g2HDSERWd02W14jJPG7K5h27Ocd6fLcNyiIladSePEe+heihFd+b9aVMT0W8Pe+7bbveq0GrQvrs7BnsYCYPDlqtt9CH+1qAbHlvMvPfy3OQGfDLrDszYF2gtCtdlA4t9mIFwfD7qXzY1w+hh1/+w16YFGw273a6s/e0GotrhHAtkg+Ubn3e4sHLfYA1+78+YqMGA89OefhpOsk8Z48NKkf+iDPxIjttgX8+68Sfcw7XabtaCnjttugyEc+PPS7d6F4xZ74GIQJzkbMUNz6M9tW9/ZB77qvxx2zxvMIMW+tRWE1+CLCHhjEP0ZtvM/r8DXbvdXI/bH2ct74Y/7s8V+OBt0u64NqhEpF/4M2iaRvbF0KeRnf9QAxP9ctiuBXoNZt/t91FQO+Uv0p+1SfA2uQMKmVhr8/ICLtwnQqzCGA5o3pD9S32mO+78HRv92u430eSLguDgP/GkrPPvjoydhEyo0vhT+3Lb1g/3R7zyAhPPwV824g+1sNP/9HXALEg7Owh/14u5J+PPQ2rfX4CtI+FJ/DCwJlcSG3e4Xf6LFfnBOoplZaORWwENzDUK/A8Y/QMOhk/e6YwQpj7YF7FfCJSk/ap+lQ9C2kPJOt/vYa/3PnhCFWQh/nptI8keufND9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",
          fileName="modelica://DynTherM/Figures/Electrical_model.png")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-80},{140,
            80}})),
    experiment(StopTime=1200, __Dymola_Algorithm="Dassl"));
end CellHeatLoss;
