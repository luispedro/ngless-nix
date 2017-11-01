{ mkDerivation
, atomic-write, bytestring-lexing, gitrev, regex, safeio
, aeson, ansi-terminal, async, base, bytestring
, bzlib, bzlib-conduit, conduit, conduit-algorithms, conduit-combinators
, conduit-extra, configurator, containers, convertible, data-default, deepseq
, directory, double-conversion, edit-distance, either, errors, extra
, file-embed, filemanip, filepath, hashable, hashtables
, http-client, http-conduit, HUnit, IntervalMap, MissingH, mtl
, network, old-locale, optparse-applicative, parallel, parsec
, primitive, process, QuickCheck, random, resourcet, stdenv, stm
, stm-chans, stm-conduit, strict, tar, template-haskell
, test-framework, test-framework-hunit, test-framework-quickcheck2
, test-framework-th, text, time, transformers, unix, vector
, vector-algorithms, yaml, zlib
, ghc
, hpack
# , fetchurl
, fetchFromGitHub
, makeWrapper
, python
, pkgs
}:
mkDerivation {
  pname = "NGLess";
  version = "0.5.0";
  src = fetchFromGitHub {
    owner = "luispedro";
    repo = "ngless";
    rev = "d0499847703010f787f258e23fafd77cd8fc2419";
    sha256 = "17w3yqcwk8v2ab0a0rlx22n43zg3v3qr3x84m0277rn89hg7d0gl";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson ansi-terminal async base bytestring bzlib bzlib-conduit
    atomic-write bytestring-lexing gitrev regex safeio
    conduit-algorithms
    conduit conduit-combinators conduit-extra configurator containers
    convertible data-default deepseq directory double-conversion
    edit-distance either errors extra file-embed filemanip filepath hashable
    hashtables http-client http-conduit IntervalMap MissingH mtl
    network old-locale optparse-applicative parallel parsec primitive
    process random resourcet stm stm-chans stm-conduit strict tar
    template-haskell text time transformers unix vector
    vector-algorithms yaml zlib
    pkgs.wget
    pkgs.samtools
    pkgs.bwa
    python
    makeWrapper
  ];
  testHaskellDepends = [
    aeson ansi-terminal async base bytestring bzlib bzlib-conduit
    atomic-write bytestring-lexing gitrev regex safeio
    conduit-algorithms
    conduit conduit-combinators conduit-extra configurator containers
    convertible data-default deepseq directory double-conversion
    edit-distance either errors extra file-embed filemanip filepath hashable
    hashtables http-client http-conduit HUnit IntervalMap MissingH mtl
    network old-locale optparse-applicative parallel parsec primitive
    process QuickCheck random resourcet stm stm-chans stm-conduit
    strict tar template-haskell test-framework test-framework-hunit
    test-framework-quickcheck2 test-framework-th text time transformers
    unix vector vector-algorithms yaml zlib
  ];
  configureFlags = "-f-embed";
  license = stdenv.lib.licenses.mit;

  prePatch = ''
    hpack
  '';

  buildTools = [ hpack ];

  postBuild = ''
    make modules
  '';

  postInstall = ''
    mkdir -p $out/share/ngless/data
    mkdir -p $out/share/ngless/bin
    cp -pr Modules $out/share/ngless/data
    wrapProgram $out/bin/ngless \
        --set NGLESS_SAMTOOLS_BIN ${pkgs.samtools}/bin/samtools \
        --set NGLESS_BWA_BIN ${pkgs.bwa}/bin/bwa
  '';
}
