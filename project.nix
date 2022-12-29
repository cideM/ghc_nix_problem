{ mkDerivation, base, lib, modern-uri }:
mkDerivation {
  pname = "ghc-nix-problem";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base modern-uri ];
  license = lib.licenses.bsd3;
  mainProgram = "ghc-nix-problem";
}
