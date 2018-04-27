
## Setting up NANUK1 / OPA -- OASIS -- SAS-LIM3

### 1/ Compiling

#### 1.1 Compile OASIS

OASIS needs to be compiled first because both XIOS and NENO depend on it.

    svn co https://oasis3mct.cerfacs.fr/svn/branches/OASIS3-MCT_3.0_branch/oasis3-mct

    cd oasis3-mct/util/make_dir

Create and adapt your own "make.\<YOUR_ARCH\>" file
    
    make -f TopMakefileOasis3

If everything goes according to plan you should find these in "oasis3-mct/lib/":
    
    libmct.a  libmpeu.a  libpsmile.MPI1.a  libscrip.a


#### 1.2 Compile XIOS

I use the trunk version, my version is compiled upon revision "1442", so to be sure:

    svn co -r 1442 http://forge.ipsl.jussieu.fr/ioserver/svn/XIOS/trunk xios_trunk

I guess you had to compile xios before so you know how to do it, just mind the
extra oasis-related flag in our particular case:

    ./make_xios --arch YOUR_ARCH --prod --full --use_oasis oasis3_mct --netcdf_lib netcdf4_seq --job 6


#### 1.3 NEMO opa.exe and sas.exe

Now, it's getting trickier since we won't compile a single "nemo.exe" out of NEMO
but one "nemo.exe" that we shall rename "opa.exe" and another "nemo.exe" that
we shall rename "sas.exe".

Get the up-to-date source of NEMO version 3.6

    svn co http://forge.ipsl.jussieu.fr/nemo/svn/branches/2015/nemo_v3_6_STABLE/NEMOGCM

As usual create and adapt your own "NEMOGCM/ARCH/arch-YOUR_ARCH.fcm", mind this
time to complete the "OASIS" and "XIOS" paths according to your new OASIS and
XIOS install...

Now in the NEMOGCM/CONFIG directory, add the 2 new entries for the two
executables to compile into file "cfg.txt":
    
    NANUK1_OPA OPA_SRC
    NANUK1_SAS_LIM3 OPA_SRC SAS_SRC LIM_SRC_3
    
You start to get it there is this "NANUK1_OPA" config in which we will compile
what will eventually become "opa.exe" and this "NANUK1_SAS_LIM3" config in which we will compile
what will become "sas.exe". So:

    cd ./CONFIG/
    mkdir NANUK1_OPA NANUK1_SAS_LIM3

Fill these two directories with what you find in the following google drive directory into:
https://drive.google.com/open?id=1zxrsqfva5L7vAHCr1LzkU_zT2UmNbG2B

Have a look at the "CPP" file in each directory, it might give you a hint on what we really
do... Like for instance, "key_lim3" is obviously only used for the "NANUK1_SAS_LIM3" config.

So now you just have to compile two "nemo.exe" and rename them accordingly:

    ./makenemo -m YOUR_CONF -n NANUK1_SAS_LIM3 -j 8
    mv -f NANUK1_SAS_LIM3/BLD/bin/nemo.exe NANUK1_SAS_LIM3/BLD/bin/sas.exe

    ./makenemo -m YOUR_CONF -n NANUK1_OPA -j 8
    mv -f NANUK1_OPA/BLD/bin/nemo.exe NANUK1_OPA/BLD/bin/opa.exe

We're done with compiling stuffs!




