{ buildPythonPackage, fetchPypi, pytestCheckHook, typing-extensions }:

buildPythonPackage rec {
  pname = "pygeoif";
  version = "0.7";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-EaoMBx04vvpK870SPvqDSr4II6hz83RPCgcKRAJa/gQ=";
  };

  propagatedBuildInputs = [ typing-extensions ];
  nativeCheckInputs = [ pytestCheckHook ];
}
