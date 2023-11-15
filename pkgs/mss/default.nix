{ python3, qtbase, wrapQtAppsHook, fetchFromGitHub, xvfb-run }:

python3.pkgs.buildPythonApplication rec {
  pname = "MSS";
  version = "8.3.2";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "Open-MSS";
    repo = "MSS";
    rev = version;
    hash = "sha256-69hJ6O4TYbPI5qDd/thheEACbqaCbI66iFpUqbi3mSs=";
  };

  buildInputs = [ qtbase ];
  propagatedBuildInputs = with python3.pkgs; [
    basemap
    chameleon
    click
    email-validator
    fastkml
    flask
    flask-cors
    flask-httpauth
    # flask-mail
    # flask-migrate
    flask-socketio
    flask-testing
    flask-wtf
    fs
    fs_filepicker
    fslib
    gitpython
    gpxpy
    isodate
    keyring
    markdown
    metpy
    multidict
    nco
    netcdf4
    owslib
    passlib
    pint
    pycountry
    pyjwt
    pyqt5
    pysaml2
    python-engineio
    python-socketio
    shapely
    skyfield
    skyfield-data
    sqlalchemy
    unicodecsv
    validate-email
    websocket-client
    werkzeug
    xstatic
    xstatic-bootstrap
    xstatic-jquery
    # (flask-socketio.override {
    #   python-socketio = python-socketio.override {
    #     python-engineio = python-engineio.overrideAttrs (old: rec {
    #       format = "pyproject";
    #       version = "4.7.0";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "miguelgrinberg";
    #         repo = "python-engineio";
    #         rev = "v${version}";
    #         hash = "sha256-H8aM/l/x7xvZx/HaLdzjwB2SozxvuBuhH6JMbuBJwA8=";
    #       };
    #     });
    #   };
    # })
  ];

  nativeBuildInputs = with python3.pkgs; [
    future
    wrapQtAppsHook
  ];

  nativeCheckInputs = [
    xvfb-run
  ] ++ (with python3.pkgs; [
    mock
    pytest
    pytest-cov
  ]);

  patches = [ ./fix-git-repo-error.patch ./fix-werkzeug-refusing-to-start.patch ];

  # Properly wrap the pyqt application
  dontWrapQtApps = true;
  preFixup = ''
    wrapQtApp "$out/bin/msui"
  '';

  checkPhase = ''
    runHook preCheck

    export HOME="$(mktemp -d)"

    echo -e '#!/bin/sh\nset -euo pipefail\npytest "$@"' > "pytest-qt"
    chmod +x "pytest-qt"
    wrapQtApp "pytest-qt"
    xvfb-run -s '-screen 0 800x600x24' ./pytest-qt -x

    # ./pytest-qt-xvfb -v --durations=20 --reverse --cov=mslib -k 'not test_mss_rename_message' tests \
    #   || (for i in {1..5} \
    #     ; do ./pytest-qt-xvfb tests -v --durations=0 --reverse --last-failed --lfnf=none -k 'not test_mss_rename_message' \
    #       && break \
    #   ; done)

    runHook postCheck
  '';
}
