{ buildPythonPackage, fetchFromGitHub, pytest, pytest-timeout, mock, fs, humanfriendly, pyqt5, qt5, xvfb-run }:

buildPythonPackage rec {
  pname = "fs_filepicker";
  version = "0.3.8";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "Open-MSS";
    repo = pname;
    rev = version;
    hash = "sha256-p4Uxl+kVSNUBlfclceArfLTsJxyxHTze1FhzH2CKXvI=";
  };

  propagatedBuildInputs = [ fs humanfriendly pyqt5 ];
  nativeBuildInputs = [ qt5.wrapQtAppsHook ];
  nativeCheckInputs = [ pytest pytest-timeout mock xvfb-run ];

  # Properly wrap the pyqt application
  dontWrapQtApps = true;
  preFixup = ''
    wrapQtApp "$out/bin/fs_filepicker"
  '';

  checkPhase = ''
    runHook preCheck

    export HOME="$(mktemp -d)"
    echo -e '#!/bin/sh\nset -euo pipefail\npytest "$@"' > pytest-qt
    chmod +x pytest-qt
    patchShebangs pytest-qt
    wrapQtApp pytest-qt
    xvfb-run -s '-screen 0 1280x1024x24' ./pytest-qt -v --durations=20 tests

    runHook postCheck
  '';
}
