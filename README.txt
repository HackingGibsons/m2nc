This is something like netcat, but it speaks to Mongrel2

Requires:
        * SBCL 1.0.48~ish
        * QuickLisp
        * M2CL Mongrel2 bindings -- https://github.com/galdor/m2cl
        * ~/.sbclrc that loads quicklisp

Getting Started:
        * git clone git://github.com/HackingGibsons/m2nc.git
        * cd m2nc
        * script/build
          [ This will churn to compile your executable ]
        * bin/m2nc

Installing:
        * Get started
        * Put bin/m2nc wherever you'd like it

Usage:
        $ echo "Hello world" | m2nc -s tcp://subscribe-address -p tcp://publish-address
        [ Hit Mongrel2 with a request that would cause this handler to get hit ]
        [ It will respond with "Hello world" across the wire and exit ]
        [ .. It's pretty much netcat but for a smaller application .. ]
