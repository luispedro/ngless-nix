# ngless nix build scripts

If you use [nix](http://nixos.org), you easily build and install
[ngless](http://ngless.readthedocs.io/) using this repository:

    nix-env -i -f https://github.com/luispedro/ngless-nix/archive/master.tar.gz

This should download the nix scripts and build ngless.

If you prefer, you can also first clone the repository:

    git clone https://github.com/luispedro/ngless-nix
    cd ngless-nix
    # inspect the default.nix & ngless.nix files if you wish
    nix-env -i -f .
