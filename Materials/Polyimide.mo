within DynTherM.Materials;
model Polyimide "Material used for electrothermal heating films"
  extends Modelica.Icons.MaterialProperty;
  extends Materials.Properties(
    rho=1420,
    lambda=0.12,
    cm=1090);
  annotation (Documentation(info="<html>
<p>Reference:</p>
<p>[1] R. Roy, et al. &quot;Multiphysics anti-icing simulation of a CFRP composite wing structure embedded with thin etched-foil electrothermal heating films in glaze ice conditions&quot;, Composite Structures, 2021.</p>
</html>"));
end Polyimide;
