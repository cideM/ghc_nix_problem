# Mismatch Between Cabal and Nix Version Resolution

This project has a very simple `Main.hs` file that imports `modern-uri`. The
package should be resolved to version 0.3.4.4, since only that works with the
`base` version that comes with GHC 8.10.7, which is used in this project. Cabal
gets that right, but Nix doesn't.

The issue is likely that the package set that comes with GHC 8.10.7 in Nix
happens to have `modern-uri` 0.3.6.0.

These commands will demonstrate the difference:
```shell
$ cabal run
Up to date
URI {uriScheme = Just "https", uriAuthority = Right (Authority {authUserInfo = Nothing, authHost = "markkarpov.com", authPort = Nothing}), uriPath = Nothing, uriQuery = [], uriFragment = Nothing}
$ nix run
warning: Git tree '/Users/fbs/private/ghc_nix_problem' is dirty
error: builder for '/nix/store/bx4r1zbif27w4s12ffcnm4nxyvc9w7ff-modern-uri-0.3.6.0.drv' failed with exit code 1;
       last 10 log lines:
       >   $, called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:1024:20 in Cabal-3.2.1.0:Distribution.Simple.Configure
       >   configureFinalizedPackage, called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:477:12 in Cabal-3.2.1.0:Distribution.Simple.Configure
       >   configure, called at libraries/Cabal/Cabal/Distribution/Simple.hs:625:20 in Cabal-3.2.1.0:Distribution.Simple
       >   confHook, called at libraries/Cabal/Cabal/Distribution/Simple/UserHooks.hs:65:5 in Cabal-3.2.1.0:Distribution.Simple.UserHooks
       >   configureAction, called at libraries/Cabal/Cabal/Distribution/Simple.hs:180:19 in Cabal-3.2.1.0:Distribution.Simple
       >   defaultMainHelper, called at libraries/Cabal/Cabal/Distribution/Simple.hs:116:27 in Cabal-3.2.1.0:Distribution.Simple
       >   defaultMain, called at Setup.hs:6:8 in main:Main
       > Setup: Encountered missing or private dependencies:
       > base >=4.15 && <5.0
       >
       For full logs, run 'nix log /nix/store/bx4r1zbif27w4s12ffcnm4nxyvc9w7ff-modern-uri-0.3.6.0.drv'.
error: 1 dependencies of derivation '/nix/store/zsvz79qsaldv7ff7acvzn91l2j4fizql-ghc-nix-problem-0.1.0.0.drv' failed to build
```
