{ buildPythonPackage, fetchPypi, setuptools }:

buildPythonPackage rec {
  pname = "nco";
  version = "1.1.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-DQI8TjDbNB9uq9yNeYLDnk+5nHPtxdW2BVUJeAPxjgU=";
  };

  nativeBuildInputs = [ setuptools ];
}
