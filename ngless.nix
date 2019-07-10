{ mkDerivation, fetchFromGitHub, aeson, ansi-terminal, async, atomic-write
, base , bytestring, bytestring-lexing, bzlib-conduit, conduit
, conduit-algorithms, conduit-extra, configurator, containers
, convertible, criterion, data-default, deepseq, diagrams-core
, diagrams-lib, diagrams-svg, directory, double-conversion
, edit-distance, either, errors, exceptions, extra, file-embed
, filemanip, filepath, gitrev, hashable, hashtables, hostname
, hpack, http-client, http-conduit, HUnit, inline-c, inline-c-cpp
, IntervalMap, MissingH, mtl, network, optparse-applicative, parsec
, primitive, process, QuickCheck, regex, resourcet, safe, safeio
, stdenv, stm, stm-chans, stm-conduit, strict, tar, tar-conduit
, template-haskell, test-framework, test-framework-hunit
, test-framework-quickcheck2, test-framework-th, text, time
, transformers, unix, unix-compat, unliftio, unliftio-core, vector
, vector-algorithms, yaml, zlib
, samtools, bwa, minimap2, prodigal, megahit, makeWrapper
}:
mkDerivation rec {
  pname = "NGLess";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "ngless-toolkit";
    repo = "ngless";
    rev = "v${version}";
    sha256 = "06ygv8q2zjqsnrid1302yrlhhvb8ik48nq6n0higk3i1mdc8r0dg";
  };


  isLibrary = false;
  isExecutable = true;
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson ansi-terminal async atomic-write base bytestring
    bytestring-lexing bzlib-conduit conduit conduit-algorithms
    conduit-extra configurator containers convertible data-default
    deepseq diagrams-core diagrams-lib diagrams-svg directory
    double-conversion edit-distance either errors exceptions extra
    file-embed filemanip filepath gitrev hashable hashtables hostname
    http-client http-conduit inline-c inline-c-cpp IntervalMap MissingH
    mtl network optparse-applicative parsec primitive process regex
    resourcet safe safeio stm stm-chans stm-conduit strict tar
    tar-conduit template-haskell text time transformers unix
    unix-compat unliftio unliftio-core vector vector-algorithms yaml
    zlib

    makeWrapper
  ];
  testHaskellDepends = [
    aeson ansi-terminal async atomic-write base bytestring
    bytestring-lexing bzlib-conduit conduit conduit-algorithms
    conduit-extra configurator containers convertible data-default
    deepseq diagrams-core diagrams-lib diagrams-svg directory
    double-conversion edit-distance either errors exceptions extra
    file-embed filemanip filepath gitrev hashable hashtables hostname
    http-client http-conduit HUnit inline-c inline-c-cpp IntervalMap
    MissingH mtl network optparse-applicative parsec primitive process
    QuickCheck regex resourcet safe safeio stm stm-chans stm-conduit
    strict tar tar-conduit template-haskell test-framework
    test-framework-hunit test-framework-quickcheck2 test-framework-th
    text time transformers unix unix-compat unliftio unliftio-core
    vector vector-algorithms yaml zlib
  ];
  benchmarkHaskellDepends = [
    aeson ansi-terminal async atomic-write base bytestring
    bytestring-lexing bzlib-conduit conduit conduit-algorithms
    conduit-extra configurator containers convertible criterion
    data-default deepseq diagrams-core diagrams-lib diagrams-svg
    directory double-conversion edit-distance either errors exceptions
    extra file-embed filemanip filepath gitrev hashable hashtables
    hostname http-client http-conduit HUnit inline-c inline-c-cpp
    IntervalMap MissingH mtl network optparse-applicative parsec
    primitive process regex resourcet safe safeio stm stm-chans
    stm-conduit strict tar tar-conduit template-haskell text time
    transformers unix unix-compat unliftio unliftio-core vector
    vector-algorithms yaml zlib
  ];

  preConfigure = ''
    make NGLess/Dependencies/Versions.hs
    hpack
  '';

  postInstall = ''
    mkdir -p $out/share/ngless/data
    mkdir -p $out/share/ngless/bin
    cp -pr Modules $out/share/ngless/data
    wrapProgram $out/bin/ngless \
        --set NGLESS_SAMTOOLS_BIN ${samtools}/bin/samtools \
        --set NGLESS_BWA_BIN ${bwa}/bin/bwa \
        --set NGLESS_MINIMAP2_BIN ${minimap2}/bin/minimap2 \
        --set NGLESS_PRODIGAL_BIN ${prodigal}/bin/prodigal \
        --set NGLESS_MEGAHIT_BIN ${megahit}/bin/megahit
  '';

  homepage = "https://ngless.embl.de/";
  license = stdenv.lib.licenses.mit;
}
