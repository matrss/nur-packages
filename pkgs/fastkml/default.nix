{ buildPythonPackage, fetchPypi, pytestCheckHook, python-dateutil, pygeoif }:

buildPythonPackage rec {
  pname = "fastkml";
  version = "0.12";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NNjrL3e1VAAnQ7uL5WePidjs6lpk3tFIACj0NAXYtjg=";
  };

  propagatedBuildInputs = [ python-dateutil pygeoif ];
  nativeCheckInputs = [ pytestCheckHook ];
}
