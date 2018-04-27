
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
    
I guess, you start to get it there, it is in the "NANUK1_OPA" config that we
will compile what will eventually become "opa.exe" and in the "NANUK1_SAS_LIM3"
that we will compile what will become "sas.exe". So:

    cd ./CONFIG/

In "CONFIG" add eveything you find in the following google drive directory:

    NEMO_stuff/NEMO_CONFIG/NANUK1/NANUK1_OPA_OA3_SASLIM3_nemo_3.6/CONFIG

Link: https://drive.google.com/open?id=1zxrsqfva5L7vAHCr1LzkU_zT2UmNbG2B

Namely: 

    cfg.txt NANUK1_OPA NANUK1_SAS_LIM3


Have a look at the "CPP" file in each directory, it might give you a hint on what we really
do... Like for instance, "key_lim3" is obviously only used for the "NANUK1_SAS_LIM3" config.

So now you just have to compile two "nemo.exe" and rename them accordingly:

    ./makenemo -m YOUR_CONF -n NANUK1_SAS_LIM3 -j 8
    mv -f NANUK1_SAS_LIM3/BLD/bin/nemo.exe NANUK1_SAS_LIM3/BLD/bin/sas.exe

    ./makenemo -m YOUR_CONF -n NANUK1_OPA -j 8
    mv -f NANUK1_OPA/BLD/bin/nemo.exe NANUK1_OPA/BLD/bin/opa.exe

We're done with compiling stuffs!




### 2/ Preparing and launching a simulation


In your run directory, before launching the monster you need to have:

* The 3 executables (see 1): opa.exe, sas.exe, xios_server.exe

* All appropriate NetCDF files (see 2.1)

* The control ASCII files (see 2.2)


#### 2.1 Setup and forcing NetCDF files

All the netcdf files needed are the in tarball "NANUK1_DATA_RUNDIR.tar.gz" in
this directory on the drive (should replace all previous version):

    NEMO_stuff/NEMO_CONFIG_DATA/NANUK1/

Link: https://drive.google.com/open?id=1rC8UUsIAQ4YTKAmHp4ZXqo-3qBU8OF4h

NOTE: The files for the DFS5 atmospheric forcing, year 2010 are not included, I assume you
have them already.


#### 2.2 Namelists and XIOS xml files

The appropriate namelists for opa.exe, sas.exe and OASIS, respectively:

    namelist_cfg & namelist_ref, namelist_sas_cfg & namelist_sas_ref & namelist_ice_cfg & namelist_ice_ref, namcouple

Are to be found in the google drive directory "NANUK1_OPA_OA3_SASLIM3_CTRL_nemo_3.6" in :

    NEMO_stuff/NEMO_CONFIG_CTRL/NANUK1/

Link: https://drive.google.com/open?id=1CfT0F-_9CZpA0MAApGw33bEhAXfATvy8

All XML files for XIOS are in the same directory...

