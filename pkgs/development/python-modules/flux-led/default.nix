{ lib
, async-timeout
, buildPythonPackage
, fetchFromGitHub
, webcolors
, pythonOlder
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "flux-led";
  version = "1.0.2";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "Danielhiversen";
    repo = "flux_led";
    rev = "refs/tags/${version}";
    hash = "sha256-DfC92gqPP9Lky4gX2v8/AbZgM7uRCKjRQC2nS/sDHsY=";
  };

  propagatedBuildInputs = [
    async-timeout
    webcolors
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace '"pytest-runner>=5.2",' ""
  '';

  pytestFlagsArray = [
    "tests.py"
  ];

  pythonImportsCheck = [
    "flux_led"
  ];

  meta = with lib; {
    description = "Python library to communicate with the flux_led smart bulbs";
    homepage = "https://github.com/Danielhiversen/flux_led";
    changelog = "https://github.com/Danielhiversen/flux_led/releases/tag/${version}";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ colemickens ];
    platforms = platforms.linux;
  };
}
