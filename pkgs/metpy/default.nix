{ buildPythonPackage, fetchPypi, xarray, traitlets, scipy, pyproj, pooch, pint, matplotlib }:

buildPythonPackage rec {
  pname = "MetPy";
  version = "1.5.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-q+6UAzZCwG7+ysOqvCJESRJPFP2wHeEgAfMk2lTORsc=";
  };

  propagatedBuildInputs = [
    matplotlib
    pint
    pooch
    pyproj
    scipy
    traitlets
    xarray
  ];
}
