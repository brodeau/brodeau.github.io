
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

*HEXAGON update:*

- use my compiled oasis:

        /home/lbr074/DEV/oasis3-mct
      
- alternatively, for recompiling, "arch.HEXAGON" and tweaked "TopMakefileOasis3" are to be found in: https://drive.google.com/drive/folders/1626sPoSy0eqOcxL_aj9Z-9ecg2qWtDzk

***
***

#### 1.2 Compile XIOS

I use the trunk version, my version is compiled upon revision "1442", so to be sure:

    svn co -r 1442 http://forge.ipsl.jussieu.fr/ioserver/svn/XIOS/trunk xios_trunk

I guess you had to compile xios before so you know how to do it, just mind the
extra oasis-related flag in our particular case:

    ./make_xios --arch YOUR_ARCH --prod --full --use_oasis oasis3_mct --netcdf_lib netcdf4_seq --job 6

*HEXAGON update:*

- use my compiled xios:

        /home/lbr074/DEV/xios_trunk_oa3
    
- alternatively, for recompiling, all the arch files to be found into: https://drive.google.com/drive/folders/1q5P7coRRGV3aHXp-c-HwSbEcqji6XN7z

***
***

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

*HEXAGON update:*

- arch file "arch-HEXAGON_OA3.fcm" is in: https://drive.google.com/drive/folders/1hLeV-y58WsrHTqx-sdyOX64MUmuMGk6y

***
***
***

### 2/ Preparing and launching a simulation


In your run directory, before launching the monster you need to have:

* The 3 executables (see 1): opa.exe, sas.exe, xios_server.exe

* All appropriate NetCDF files (see 2.1)

* The control ASCII files (see 2.2)

***
***

#### 2.1 Setup and forcing NetCDF files

All the netcdf files needed are the in tarball "NANUK1_DATA_RUNDIR.tar.gz" in
this directory on the drive (should replace all previous version):

    NEMO_stuff/NEMO_CONFIG_DATA/NANUK1/

Link: https://drive.google.com/open?id=1rC8UUsIAQ4YTKAmHp4ZXqo-3qBU8OF4h

NOTE: The files for the DFS5 atmospheric forcing, year 2010 are not included, I assume you
have them already.

*HEXAGON update:*

On HEXAGON they are installed here:

    /work/users/lbr074/setups/NANUK1/NANUK1-I


***
***

#### 2.2 Namelists and XIOS xml files

The appropriate namelists for opa.exe, sas.exe and OASIS, respectively:

    namelist_cfg & namelist_ref, namelist_sas_cfg & namelist_sas_ref & namelist_ice_cfg & namelist_ice_ref, namcouple

are to be found in the google drive directory "NANUK1_OPA_OA3_SASLIM3_CTRL_nemo_3.6" in :

    NEMO_stuff/NEMO_CONFIG_CTRL/NANUK1/

Link: https://drive.google.com/open?id=1CfT0F-_9CZpA0MAApGw33bEhAXfATvy8

All XML files for XIOS are in the same directory...


*HEXAGON update:*

Check my own production directory in which the setup worked okay:

    /work/users/lbr074/simus/tmp/NANUK1_SASOA3/NANUK1_SASOA3-SOAN100HX_prod/

***
***

#### 2.3 Launching the beast

An example (I have no idea if it is the right ratio of processes for OPA/SAS) :

    mpirun -np 25 ./opa.exe : -np 16 ./sas.exe : -np 1 ./xios_server.exe

(we have nodes with 48 cores on Marenostrum, that's why. Otherwize I would tend
to use less of course...

Of course mind the cpu decomposition according to the number of cores you use
for each component.

In this particular case, for "opa.exe", in namelist_cfg, I have:

    &nammpp
    jpni=5
    jpnj=5
    jpnij=25
    /

for "sas.exe", in namelist_sas_cfg, I have:

    &nammpp
    jpni=4
    jpnj=4
    jpnij=16
    /

*HEXAGON update:*

There are 16 cores per node, and apparently "aprun" which replace "mpirun" on Cray machines doesn't like to mix different executables on the same node. So I use 1 node for opa.exe, 1 for sas.exe and a third one for xios_server.exe (only using 4 cores on this 3rd node though). The launch command looks like this:

    aprun -n 16 ./opa.exe : -n 16 ./sas.exe : -n 4 ./xios_server.exe

In terms of namelist that just means that for both OPA and SAS we have:

    &nammpp
    jpni=4
    jpnj=4
    jpnij=16
    /

The SLURM script batch script "run_NANUK1_SASOA3-SOAN100HX.sub" I use to launch the run looks like this:

	#!/bin/bash                                                                                                                       
	#SBATCH -J SOAN100HX                                                                                                              
	#SBATCH -N 3                                                                                                                      
	#SBATCH -n 48                                                                                                                     
	#SBATCH -o out_NANUK1_SASOA3-SOAN100HX_20100101_20101231_00036.out                                                                
	#SBATCH -e err_NANUK1_SASOA3-SOAN100HX_20100101_20101231_00036.err                                                                
	#SBATCH -t 00:59:00                                                                                                               
	
	ulimit -s unlimited
	
	echo
	
	list_nodes_c=`scontrol show hostname  | paste -d, -s`
	list_nodes=`echo ${list_nodes_c} | sed -e s/','/' '/g`
	
	echo
	echo "  *** JOB ID => ${SLURM_JOB_ID} "
	echo "  *** Nodes to be booked: ${list_nodes} !"
	
	cd /work/users/lbr074/simus/tmp/NANUK1_SASOA3/NANUK1_SASOA3-SOAN100HX_prod/ ; # My production directory...
	
	echo; echo "In `pwd`"; echo; \ls -l; echo
	
	CMD="aprun -n 16 ./opa.exe : -n 16 ./sas.exe : -n 4 ./xios_server.exe"
	
	echo ${CMD}
	${CMD}
	
	exit

To be launched like:

    sbatch ./run_NANUK1_SASOA3-SOAN100HX.sub

***
***
***

/laurent
