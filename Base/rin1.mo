within DynTherM.Base;
partial model rin1 "One radiative inlet"
  DynTherM.CustomInterfaces.IrradiancePort radiative
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end rin1;
