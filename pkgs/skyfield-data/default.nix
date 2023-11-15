{ buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "skyfield-data";
  version = "5.0.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-/jSEAoz5brgEAQTQYm7HEvc+IuD5eh7uYlJyB+6tZsg=";
  };
}
