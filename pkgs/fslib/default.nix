{ buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "fslib";
  version = "0.3.4";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-0vaUnaCrFAyKeDbC1oNPvm7If5HC3DaBccwAhzOhjSI=";
  };
}
