!!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
!! NEMO/OPA  Configuration namelist : used to overwrite defaults values defined in SHARED/namelist_ref
!!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
!
!-----------------------------------------------------------------------
&namrun        !   parameters of the run
!-----------------------------------------------------------------------
   nn_no       =       0   !  job number (no more used...)
   cn_exp      =  '<CONFCASE>'
   nn_it000    =    <IT000>   !  first time step
   nn_itend    =    <ITEND>   !  last  time step (std 5475)
   nn_date0    =    <DATE0>   !  date at nit_0000 (format yyyymmdd) used if ln_rstart=F or (ln_rstart=T and nn_rstctl=0 or 1)
   nn_leapy    =       1   !  Leap year calendar (1) or not (0)
   ln_rstart   = .<RSTRT>.   !  start from rest (F) or from a restart file (T)
   nn_rstctl   =  <IRCTL>   !  restart control => activated only if ln_rstart = T
                           !    = 0 nn_date0 read in namelist ; nn_it000 : read in namelist
                           !    = 1 nn_date0 read in namelist ; nn_it000 : check consistancy between namelist and restart
                           !    = 2 nn_date0 read in restart  ; nn_it000 : check consistancy between namelist and restart
   cn_ocerst_in  = 'restart'
   cn_ocerst_out = 'restart_oce'
   nn_istate   =    0    !  output the initial state (1) or not (0)
   nn_stock    =   1080   ! lolo: 12h at dt=40s  frequency of creation of a restart file (modulo referenced to 1)
   nn_write    =   1080   ! lolo: 12h at dt=40s  frequency of write in the output file   (modulo referenced to nn_it000)
!   nn_stock    =   1440   ! lolo: 1d at dt=60s  frequency of creation of a restart file (modulo referenced to 1)
!   nn_write    =   1440   ! lolo: 1d at dt=60s  frequency of write in the output file   (modulo referenced to nn_it000)
   ln_dimgnnn  = .false.   !  DIMG file format: 1 file for all processors (F) or by processor (T)
   ln_mskland  = .false.   !lolo  mask land points in NetCDF outputs (costly: + ~15%)
   ln_clobber  = .false.   !  clobber (overwrite) an existing file
   nn_chunksz  =       0   !  chunksize (bytes) for NetCDF file (works only with iom_nf90 routines)
/
!-----------------------------------------------------------------------
&namcfg     !   parameters of the configuration
!-----------------------------------------------------------------------
   cp_cfg      =  'enatl'   !  name of the configuration
   jp_cfg      =      60   !  resolution of the configuration
   jpidta      =     8354              !  1st lateral dimension ( >= jpi )
   jpjdta      =     4729              !  2nd    "         "    ( >= jpj )
   jpkdta      =     300               !  number of levels      ( >= jpk )
   jpiglo      =     8354              !  1st dimension of global domain --> i =jpidta
   jpjglo      =     4729              !  2nd    -                  -    --> j =jpjdta
   jpizoom     =       1   !  left bottom (i,j) indices of the zoom
   jpjzoom     =       1   !  in data domain indices
   jperio      =       0   !  lateral cond. type (between 0 and 6)
/
!-----------------------------------------------------------------------
&namzgr        !   vertical coordinate
!-----------------------------------------------------------------------
   ln_zps      = .true.    !  z-coordinate - partial steps   (T/F)
/
!-----------------------------------------------------------------------
&namzgr_sco    !   s-coordinate or hybrid z-s-coordinate
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namdom        !   space and time domain (bathymetry, mesh, timestep)
!-----------------------------------------------------------------------
   nn_closea   =    0      !  remove (=0) or keep (=1) closed seas and lakes (ORCA)
   nn_msh      =    0      !  create (=1) a mesh file or not (=0)
   rn_hmin     =   -3      !LOLO!  min depth of the ocean (>0) or min number of ocean level (<0)
   rn_e3zps_min=   25.     !  partial step thickness is set larger than the minimum of
   rn_e3zps_rat=    0.2    !  rn_e3zps_min and rn_e3zps_rat*e3t, with 0<rn_e3zps_rat<1
                           !
   rn_rdt      =   40.     !  time step for the dynamics (and tracer if nn_acc=0)
 
   ln_crs      = .false.      !  Logical switch for coarsening module
   jphgr_msh   =       0               !  type of horizontal mesh
                                       !  = 0 curvilinear coordinate on the sphere read in coordinate.nc
                                       !  = 1 geographical mesh on the sphere with regular grid-spacing
                                       !  = 2 f-plane with regular grid-spacing
                                       !  = 3 beta-plane with regular grid-spacing
                                       !  = 4 Mercator grid with T/U point at the equator
   ppglam0     =  999999.d0            !  longitude of first raw and column T-point (jphgr_msh = 1)
   ppgphi0     =  999999.d0            ! latitude  of first raw and column T-point (jphgr_msh = 1)
   ppe1_deg    =  999999.d0            !  zonal      grid-spacing (degrees)
   ppe2_deg    =  999999.d0            !  meridional grid-spacing (degrees)
   ppe1_m      =  999999.d0            !  zonal      grid-spacing (degrees)
   ppe2_m      =  999999.d0            !  meridional grid-spacing (degrees)
   ppsur       =  -12539.3187051d0     !  ORCA r4, r2 and r05 coefficients
   ppa0        =    48.7693273601d0    ! (default coefficients)
   ppa1        =    42.8722426445d0    !
   ppkth       =    317.238187329d0    !
   ppacr       =    38.4998412469d0    !
   ppdzmin     =        999999.d0      !  Minimum vertical spacing
   pphmax      =        999999.d0      !  Maximum depth
   ldbletanh   =           .TRUE.      !  Use/do not use double tanf function for vertical coordinates
   ppa2        =  20.1768193931d0      !  Double tanh function parameters
   ppkth2      =  31.5541059316d0      !
   ppacr2      =  121.356963487d0      !
/
!-----------------------------------------------------------------------
&namsplit      !   time splitting parameters                            ("key_dynspg_ts")
!-----------------------------------------------------------------------
   ln_bt_fw      =    .false.          !LOLO?  Forward integration of barotropic equations
   ln_bt_av      =    .TRUE.           !  Time filtering of barotropic variables
   ln_bt_nn_auto =    .TRUE.           !  Set nn_baro automatically to be just below
                                       !  a user defined maximum courant number (rn_bt_cmax)
   nn_baro       =    30               !LOLO/30  Number of iterations of barotropic mode
                                       !  during rn_rdt seconds. Only used if ln_bt_nn_auto=F
   rn_bt_cmax    =    0.5              !  Maximum courant number allowed if ln_bt_nn_auto=T 
   nn_bt_flt     =    2                !  Time filter choice !lolo: follow Chanut and Jouano/...
                                       !  = 0 None
                                       !  = 1 Boxcar over   nn_baro barotropic steps
                                       !  = 2 Boxcar over 2*nn_baro     "        
/
!-----------------------------------------------------------------------
&namcrs        !   Grid coarsening for dynamics output and/or
               !   passive tracer coarsened online simulations
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namtsd    !   data : Temperature  & Salinity
!-----------------------------------------------------------------------
   sn_tem = 'votemper_GLORYS12V1-<CONF>_2008.nc', -12     ,'votemper',   .true.    , .true. , 'yearly'  ,    ''    ,    ''    ,    ''
   sn_sal = 'vosaline_GLORYS12V1-<CONF>_2008.nc', -12     ,'vosaline',   .true.    , .true. ,'yearly'  ,    ''    ,    ''    ,    ''
   !
   ln_tsd_init   = .<TSD_INIT>.  ! lolo: must be controled by script! Initialisation of ocean T & S with T &S input data (T) or not (F)
   ln_tsd_tradmp = .false.  !  damping of ocean T & S toward T & S input data (T) or not (F)
/
!-----------------------------------------------------------------------
&namsbc        !   Surface Boundary Condition (surface module)
!-----------------------------------------------------------------------
   nn_fsbc     = 1         !LOLO  frequency of surface boundary condition computation
   nn_isf      = 0         !  ice shelf melting/freezing                (/=0 => fill namsbc_isf)
                           !  3 = rnf file for isf
   nn_ice_embd = 1         ! embedded sea-ice (full salt and mass exchanges and pressure)
   ln_dm2dc    = .true.    !  Daily mean to diurnal cycle on short wave
   ln_ssr      = .true.    !  Sea Surface Restoring on T and/or S       (T => fill namsbc_ssr)
   nn_fwb      = 2         !LOLO: => 1???
   ln_rnf      = .true.    !LOLO!  runoffs                                   (T   => fill namsbc_rnf)
/
!-----------------------------------------------------------------------
&namsbc_core   !   namsbc_core  CORE bulk formulae
!-----------------------------------------------------------------------
!              !   file name  ! frequency (hours) ! variable   ! time interpol. !  clim   ! 'yearly'/ ! weights              ! rotation !
!              !              !  (if <0  months)  !   name     !    (logical)   !  (T/F)  ! 'monthly' ! filename             ! pairing  !
   sn_wndi     = 'drowned_u10_DFS5.2'          ,         3         , 'u10'     ,   .false.  , .false., 'yearly'  , 'weight_bicubic_512x256-<CONF>.nc' , 'Uwnd'   , ''
   sn_wndj     = 'drowned_v10_DFS5.2'          ,         3         , 'v10'     ,   .false.  , .false., 'yearly'  , 'weight_bicubic_512x256-<CONF>.nc' , 'Vwnd'   , ''
   sn_qsr      = 'drowned_radsw_DFS5.2'        ,        24         , 'radsw'   ,   .false.  , .false., 'yearly'  , 'weight_bilinear_512x256-<CONF>.nc' , ''       , ''
   sn_qlw      = 'drowned_radlw_DFS5.2'        ,        24         , 'radlw'   ,   .false.  , .false., 'yearly'  , 'weight_bilinear_512x256-<CONF>.nc' , ''       , ''
   sn_tair     = 'drowned_t2_DFS5.2'           ,         3         , 't2'      ,   .false.  , .false., 'yearly'  , 'weight_bilinear_512x256-<CONF>.nc' , ''       , ''
   sn_humi     = 'drowned_q2_DFS5.2'           ,         3         , 'q2'      ,   .false.  , .false., 'yearly'  , 'weight_bilinear_512x256-<CONF>.nc' , ''       , ''
   sn_prec     = 'drowned_precip_DFS5.2'       ,        24         , 'precip'  ,   .false.  , .false., 'yearly'  , 'weight_bilinear_512x256-<CONF>.nc' , ''       , ''
   sn_snow     = 'drowned_snow_DFS5.2'         ,        24         , 'snow'    ,   .false.  , .false., 'yearly'  , 'weight_bilinear_512x256-<CONF>.nc' , ''       , ''
   cn_dir      = './FATM/'  !  root directory for the location of the bulk files
   rn_zqt      =  2.        !  Air temperature and humidity reference height (m)
   rn_zu       = 10.        !  Wind vector reference height (m)
/
!-----------------------------------------------------------------------
&namtra_qsr    !   penetrative solar radiation
!-----------------------------------------------------------------------
!              !  file name  ! frequency (hours) ! variable  ! time interp. !  clim  ! 'yearly'/ ! weights  ! rotation ! land/sea mask !
!              !             !  (if <0  months)  !   name    !   (logical)  !  (T/F) ! 'monthly' ! filename ! pairing  ! filename      !
   sn_chl      ='CHLA_ESACCI-OC-L3S-4km-eNATL60_y2010', -1    , 'CHLA'    ,   .true.     , .true. , 'yearly'  , ''       , ''       , ''
   ln_traqsr   = .false.   !LOLO!  Light penetration (T) or not (F)
   ln_qsr_rgb  = .true.    !  RGB (Red-Green-Blue) light penetration
   ln_qsr_2bd  = .false.   !  2 bands              light penetration
/
!-----------------------------------------------------------------------
&namsbc_rnf    !   runoffs namelist surface boundary condition
!-----------------------------------------------------------------------
!              !  file name           ! frequency (hours) ! variable  ! time interp. !  clim  ! 'yearly'/ ! weights  ! rotation ! land/sea mask !
!              !                      !  (if <0  months)  !   name    !   (logical)  !  (T/F) ! 'monthly' ! filename ! pairing  ! filename      !
   sn_rnf      = 'runoff_3.1.3.nc'    ,-1                 ,'sorunoff' ,.true.        , .true. , 'yearly'  , ''       , ''       , ''
   sn_cnf      = 'runoff_3.1.3.nc'    , 0                 ,'socoefr'  , .false.      , .true. , 'yearly'  , ''       , ''       , ''
   sn_s_rnf    = 'runoffs'            ,        24         , 'rosaline',   .true.     , .true. , 'yearly'  , ''       , ''       , ''
   sn_t_rnf    = 'runoffs'            ,        24         , 'rotemper',   .true.     , .true. , 'yearly'  , ''       , ''       , ''
   sn_dep_rnf  = 'runoffs'            ,         0         , 'rodepth' ,   .false.    , .true. , 'yearly'  , ''       , ''       , ''
!
   ln_rnf_mouth = .false.    !  specific treatment at rivers mouths
   ln_rnf_depth = .false.    !  read in depth information for runoff
   ln_rnf_tem   = .false.    !  read in temperature information for runoff
   ln_rnf_sal   = .false.    !  read in salinity information for runoff
   ln_rnf_depth_ini = .true. !  compute depth at initialisation from runoff file
   rn_rnf_max   = 0.05       !  max value of the runoff climatology over global domain ( if ln_rnf_depth_ini = .true )
   rn_dep_max = 150.         !  depth over which runoffs is spread ( ln_rnf_depth_ini = .true )
   nn_rnf_depth_file = 0     ! create (=1) a runoff depth file or not (=0)
/
!-----------------------------------------------------------------------
&namsbc_ssr    !   surface boundary condition : sea surface restoring
!-----------------------------------------------------------------------
!              !   file name  ! frequency (hours) ! variable   ! time interpol. !  clim   ! 'yearly'/ ! weights  ! rotation !
!              !              !  (if <0  months)  !   name     !    (logical)   !  (T/F)  ! 'monthly' ! filename ! pairing  !
   sn_sss      = 'sss_WOA2013-1440x720-<CONF>_mean_2005-2012.nc',-1,  'sss'   ,    .true.   , .true. , 'yearly'  ,    ''    ,    ''    ,     ''
   nn_sssr     =     2     !  add a damping     term in the surface freshwater flux (=2)
/
!-----------------------------------------------------------------------
&namsbc_alb    !   albedo parameters
!-----------------------------------------------------------------------
   nn_ice_alb   =    1   !  parameterization of ice/snow albedo
                         !     0: Shine & Henderson-Sellers (JGR 1985), giving clear-sky albedo
                         !     1: "home made" based on Brandt et al. (JClim 2005) and Grenfell & Perovich (JGR 2004),
                         !        giving cloud-sky albedo
   rn_alb_sdry  =  0.85  !  dry snow albedo         : 0.80 (nn_ice_alb = 0); 0.85 (nn_ice_alb = 1); obs 0.85-0.87 (cloud-sky)
   rn_alb_smlt  =  0.75  !  melting snow albedo     : 0.65 ( '' )          ; 0.75 ( '' )          ; obs 0.72-0.82 ( '' )
   rn_alb_idry  =  0.60  !  dry ice albedo          : 0.72 ( '' )          ; 0.60 ( '' )          ; obs 0.54-0.65 ( '' )
   rn_alb_imlt  =  0.50  !  bare puddled ice albedo : 0.53 ( '' )          ; 0.50 ( '' )          ; obs 0.49-0.58 ( '' )
/
!-----------------------------------------------------------------------
&namberg       !   iceberg parameters
!-----------------------------------------------------------------------
      ln_icebergs              = .false.
/
!-----------------------------------------------------------------------
&namlbc        !   lateral momentum boundary condition
!-----------------------------------------------------------------------
   rn_shlat    =    0.     !LOLO(0)!  shlat = 0  !  0 < shlat < 2  !  shlat = 2  !  2 < shlat
                           !       free slip  !   partial slip  !   no slip   ! strong slip
   ln_vorlat   = .false.   !  consistency of vorticity boundary condition with analytical eqs.
/
!-----------------------------------------------------------------------
&namcla        !   cross land advection
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&nambdy        !  unstructured open boundaries                          ("key_bdy")
!-----------------------------------------------------------------------
   nb_bdy         = 2        !  number of open boundary sets
   ln_coords_file = .false.,.false.      !  =T : read bdy coordinates from file

   cn_dyn2d       = 'flather','flather'  ! lolo
   nn_dyn2d_dta   = 1,1                  !  = 0, bdy data are equal to the initial state
      !                       !  = 1, bdy data are read in 'bdydata   .nc' files
      !                       !  = 2, use tidal harmonic forcing data from files
      !                       !  = 3, use external data AND tidal harmonic forcing
   cn_dyn3d      =  'frs','frs'          !
   nn_dyn3d_dta  =  1,1                  !  = 0, bdy data are equal to the initial state
   !                                      !  = 1, bdy data are read in 'bdydata   .nc' files
   cn_tra        =  'frs','frs'          !
   nn_tra_dta    =  1,1                  !  = 0, bdy data are equal to the initial state
   !                                      !  = 1, bdy data are read in 'bdydata   .nc' files
   cn_ice_lim    =  'none','none'      !lolo
   nn_ice_lim_dta=  0,0                !lolo  = 0, bdy data are equal to the initial state
   !                                      !  = 1, bdy data are read in 'bdydata   .nc' files
   rn_ice_tem    = 270.,270.           !  lim3 only: arbitrary temperature of incoming sea ice
   rn_ice_sal    = 10. ,10.            !  lim3 only:      --   salinity           --
   rn_ice_age    = 30. ,30.            !  lim3 only:      --   age                --
   !
   ln_tra_dmp    =.false.,.false.       !  open boudaries conditions for tracers
   ln_dyn3d_dmp  =.false.,.false.        !  open boundary condition for baroclinic velocities
   rn_time_dmp   =  1.,1.     ! Damping time scale in days
   rn_time_dmp_out =  1.,1.   ! Outflow damping time scale
   nn_rimwidth   = 5,5        !  width of the relaxation zone
   ln_vol        = .true.     !  total volume correction (see nn_volctl parameter)
   nn_volctl     =  1         !  = 0, the total water flux across open boundaries is zero
/
!-----------------------------------------------------------------------
&nambdy_index  !  structured open boundaries definition     
!-----------------------------------------------------------------------
    ctypebdy ='S'                   ! Open boundary type (W,E,S or N)
    nbdyind  = 2                    ! indice of velocity row or column
                                    ! if ==-1, set obc at the domain boundary
                                    !        , discard start and end indices
    nbdybeg  = 2416                 ! indice of segment start
    nbdyend  = 5226                 ! indice of segment end
/
!-----------------------------------------------------------------------
&nambdy_index  !  structured open boundaries definition
!-----------------------------------------------------------------------
    ctypebdy ='N'                   ! Open boundary type (W,E,S or N)
    nbdyind  = 4727                 ! indice of velocity row or column
                                    ! if ==-1, set obc at the domain boundary
                                    !        , discard start and end indices
    nbdybeg  = 1860                 ! indice of segment start
    nbdyend  = 6025                 ! indice of segment end
/
!-----------------------------------------------------------------------
&nambdy_dta      !  open boundaries SOUTH - external data
!-----------------------------------------------------------------------
!              !   file name    ! frequency (hours) !  variable  ! time interpol. !  clim   ! 'yearly'/ ! weights  ! rotation ! land/sea mask !
!              !                !  (if <0  months)  !    name    !    (logical)   !  (T/F)  ! 'monthly' ! filename ! pairing  ! filename      !
   bn_ssh      = 'sossheig_GLORYS2V4-BDY_t_S_<CONF>_<NEMOv>',-1, 'sossheig',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_u2d      = 'boo.nc'        ,         24        , 'vobtcrtx',    .true.   , .false.,  'daily'  ,    ''            ,   ''     ,     ''
   bn_v2d      = 'boo.nc'        ,         24        , 'vobtcrty',    .true.   , .false.,  'daily'  ,    ''            ,   ''     ,     ''
   bn_u3d      = 'vozocrtx_GLORYS2V4-BDY_u_S_<CONF>_<NEMOv>',-1, 'vozocrtx',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_v3d      = 'vomecrty_GLORYS2V4-BDY_v_S_<CONF>_<NEMOv>',-1, 'vomecrty',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_tem      = 'votemper_GLORYS2V4-BDY_t_S_<CONF>_<NEMOv>',-1, 'votemper',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_sal      = 'vosaline_GLORYS2V4-BDY_t_S_<CONF>_<NEMOv>',-1, 'vosaline',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   cn_dir  =    './BDY/'
   ln_full_vel = .true.
/
!
!!-----------------------------------------------------------------------
&nambdy_dta    !  open boundaries NORTH - external data                       
!-----------------------------------------------------------------------
!              !  file name      ! frequency (hours) ! variable  ! time interp.!  clim   ! 'yearly'/ ! weights  ! rotation ! land/sea mask !
!              !                 !  (if <0  months)  !   name    !  (logical)  !  (T/F ) ! 'monthly' ! filename ! pairing  ! filename      !
   bn_ssh      = 'sossheig_GLORYS2V4-BDY_t_N_<CONF>_<NEMOv>',-1, 'sossheig',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_u2d      = 'boo.nc'        ,         24        , 'vobtcrtx',    .true.   , .false.,  'daily'  ,    ''            ,   ''     ,     ''
   bn_v2d      = 'boo.nc'        ,         24        , 'vobtcrty',    .true.   , .false.,  'daily'  ,    ''            ,   ''     ,     ''
   bn_u3d      = 'vozocrtx_GLORYS2V4-BDY_u_N_<CONF>_<NEMOv>',-1, 'vozocrtx',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_v3d      = 'vomecrty_GLORYS2V4-BDY_v_N_<CONF>_<NEMOv>',-1, 'vomecrty',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_tem      = 'votemper_GLORYS2V4-BDY_t_N_<CONF>_<NEMOv>',-1, 'votemper',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   bn_sal      = 'vosaline_GLORYS2V4-BDY_t_N_<CONF>_<NEMOv>',-1, 'vosaline',    .true.   , .false.,  'yearly'  ,    ''            ,   ''     ,     ''
   cn_dir  =    './BDY/'
   ln_full_vel = .true.
/
!
!-----------------------------------------------------------------------
&nambfr        !   bottom friction
!-----------------------------------------------------------------------
   nn_bfr      =    2      !LOLO?  type of bottom friction :   = 0 : free slip,  = 1 : linear friction
                           !                              = 2 : nonlinear friction
   rn_bfri1    =    4.e-4  !  bottom drag coefficient (linear case)
   rn_bfri2    =    1.e-3  !  bottom drag coefficient (non linear case). Minimum coeft if ln_loglayer=T
   rn_bfri2_max =   1.e-1  !  max. bottom drag coefficient (non linear case and ln_loglayer=T)
   rn_bfeb2    =    2.5e-3 !  bottom turbulent kinetic energy background  (m2/s2)
   rn_bfrz0    =    3.e-3  !  bottom roughness [m] if ln_loglayer=T
   ln_bfr2d    = .false.   !  horizontal variation of the bottom friction coef (read a 2D mask file )
   rn_bfrien   =    50.    !  local multiplying factor of bfr (ln_bfr2d=T)
   rn_tfri1    =    4.e-4  !  top drag coefficient (linear case)
   rn_tfri2    =    2.5e-3 !  top drag coefficient (non linear case). Minimum coeft if ln_loglayer=T
   rn_tfri2_max =   1.e-1  !  max. top drag coefficient (non linear case and ln_loglayer=T)
   rn_tfeb2    =    0.0    !  top turbulent kinetic energy background  (m2/s2)
   rn_tfrz0    =    3.e-3  !  top roughness [m] if ln_loglayer=T
   ln_tfr2d    = .false.   !  horizontal variation of the top friction coef (read a 2D mask file )
   rn_tfrien   =    50.    !  local multiplying factor of tfr (ln_tfr2d=T)

   ln_bfrimp   = .true.    !  implicit bottom friction (requires ln_zdfexp = .false. if true)
   ln_loglayer = .false.   !  logarithmic formulation (non linear case)
/
!-----------------------------------------------------------------------
&nambbc        !   bottom temperature boundary condition
!-----------------------------------------------------------------------
   sn_qgh      ='geothermal_flux_Goutorbe',  -12.  , 'gh_flux'    ,   .false.     , .true. , 'yearly'  ,   ''     ,   ''     ,   ''
   !
   cn_dir      = './'      !  root directory for the location of the runoff files
   ln_trabbc   = .false.   !LOLO:  Apply a geothermal heating at the ocean bottom
   nn_geoflx   =    0      !LOLO:  geothermal heat flux: = 0 no flux
                           !     = 1 constant flux
                           !     = 2 variable flux (read in geothermal_heating.nc in mW/m2)
/
!-----------------------------------------------------------------------
&nambbl        !   bottom boundary layer scheme
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&nameos        !   ocean physical parameters
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namtra_adv    !   advection scheme for tracer
!-----------------------------------------------------------------------
   ln_traadv_tvd    =  .false.  !LOLO  TVD scheme
   ln_traadv_ubs    =  .true.   !LOLO  UBS scheme
/
!-----------------------------------------------------------------------
&namtra_adv_mle !  mixed layer eddy parametrisation (Fox-Kemper param)
!-----------------------------------------------------------------------
  ln_mle    = .false.      !lolo (T) use the Mixed Layer Eddy (MLE) parameterisation
/
!----------------------------------------------------------------------------------
&namtra_ldf    !   lateral diffusion scheme for tracers
!----------------------------------------------------------------------------------
   !                       !  Operator type:
   ln_traldf_lap    =  .false.  !LOLO?  laplacian operator
   ln_traldf_bilap  =  .false.  !  bilaplacian operator   
   !
   rn_aht_0         =     0.    !  horizontal eddy diffusivity for tracers [m2/s]
/
!-----------------------------------------------------------------------
&namtra_dmp    !   tracer: T & S newtonian damping
!-----------------------------------------------------------------------
   ln_tradmp   =  .false.  !  add a damping termn (T) or not (F)
/

!!======================================================================
!!                      ***  Dynamics namelists  ***
!!======================================================================
!!   namdyn_adv    formulation of the momentum advection
!!   namdyn_vor    advection scheme
!!   namdyn_hpg    hydrostatic pressure gradient
!!   namdyn_spg    surface pressure gradient                            (CPP key only)
!!   namdyn_ldf    lateral diffusion scheme
!!======================================================================
!
!-----------------------------------------------------------------------
&namdyn_adv    !   formulation of the momentum advection
!-----------------------------------------------------------------------
   ln_dynadv_vec = .false.  !LOLO?  vector form (T) or flux form (F)
   nn_dynkeg     = 1        !LOLO? scheme for grad(KE): =0   C2  ;  =1   Hollingsworth correction
   ln_dynadv_cen2= .false. !  flux form - 2nd order centered scheme
   ln_dynadv_ubs = .true. !LOLO  flux form - 3rd order UBS      scheme
   ln_dynzad_zts = .false. !  Use (T) sub timestepping for vertical momentum advection
/
!-----------------------------------------------------------------------
&nam_vvl    !   vertical coordinate options
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namdyn_vor    !   option of physics/algorithm (not control by CPP keys)
!-----------------------------------------------------------------------
   ln_dynvor_een = .false. !LOLO  energy & enstrophy scheme  
   ln_dynvor_een_old = .true.  !LOLO  energy & enstrophy scheme - original formulation
/
!-----------------------------------------------------------------------
&namdyn_hpg    !   Hydrostatic pressure gradient option
!-----------------------------------------------------------------------
   ln_hpg_zco  = .false.   !  z-coordinate - full steps  
   ln_hpg_zps  = .false.   !LOLO IF NO VVL!  z-coordinate - partial steps (interpolation)
   ln_hpg_sco  = .true.    !LOLO IF VVL!!!  s-coordinate (standard jacobian formulation)
/
!-----------------------------------------------------------------------
&namdyn_ldf    !   lateral diffusion on momentum
!-----------------------------------------------------------------------
   !                       !  Type of the operator :
   ln_dynldf_lap    =  .false.   ! LOLO: JMM dans couche eponge... /// laplacian operator
   !                            ! LOLO: JMM mettrait plutot un bilap dans le cas ou on veut de la visco... 
   ln_dynldf_bilap  =  .false.  !  bilaplacian operator
   !
   rn_ahm_0_lap     =     0.    !  horizontal laplacian eddy viscosity   [m2/s]
   rn_ahmb_0        =     0.    !  background eddy viscosity for ldf_iso [m2/s]
   rn_ahm_0_blp     =     0.    !  horizontal bilaplacian eddy viscosity [m4/s]
/
!-----------------------------------------------------------------------
&namzdf        !   vertical physics
!-----------------------------------------------------------------------
   rn_avm0     =   1.e-4  !  vertical eddy viscosity   [m2/s]          (background Kz if not "key_zdfcst")
   rn_avt0     =   1.e-5  !  vertical eddy diffusivity [m2/s]          (background Kz if not "key_zdfcst")
   nn_avb      =    0      !  profile for background avt & avm (=1) or not (=0)
   nn_havtb    =    1      !  horizontal shape for avtb (=1) or not (=0)
   ln_zdfevd   = .true.    !  enhanced vertical diffusion (evd) (T) or not (F)
   nn_evdm     =    0      !LOLO  evd apply on tracer (=0) or on tracer and momentum (=1)
   rn_avevd    =  10.      !  evd mixing coefficient [m2/s]
   ln_zdfnpc   = .false.   !  Non-Penetrative Convective algorithm (T) or not (F)
   nn_npc      =    1            !  frequency of application of npc
   nn_npcp     =  365            !  npc control print frequency
   ln_zdfexp   = .false.   !  time-stepping: split-explicit (T) or implicit (F) time stepping
   nn_zdfexp   =    3            !  number of sub-timestep for ln_zdfexp=T
/
!-----------------------------------------------------------------------
&namzdf_tke    !   turbulent eddy kinetic dependent vertical diffusion  ("key_zdftke")
!-----------------------------------------------------------------------
   rn_ediff    =   0.1     !  coef. for vertical eddy coef. (avt=rn_ediff*mxl*sqrt(e) )
   rn_ediss    =   0.7     !  coef. of the Kolmogoroff dissipation
   rn_ebb      =   60.     !  coef. of the surface input of tke (67.83 now usual value)
   rn_emin     =   1.e-6   !  minimum value of tke [m2/s2]
   rn_emin0    =   1.e-4   !  surface minimum value of tke [m2/s2]
   rn_bshear   =   1.e-20  !  background shear (>0)
!!!   nn_mxl      =   3       !LOLO: floating invalid!!!
   nn_mxl      =   2  !LOLO(3)! mixing length: = 0 bounded by the distance to surface and bottom
                           !                 = 1 bounded by the local vertical scale factor
                           !                 = 2 first vertical derivative of mixing length bounded by 1
                           !                 = 3 as =2 with distinct disspipative an mixing length scale
   nn_pdl      =   1       !  Prandtl number function of richarson number (=1, avt=pdl(Ri)*avm) or not (=0, avt=avm)
   ln_mxl0     = .true.    !  surface mixing length scale = F(wind stress) (T) or not (F)
   rn_mxl0     =   0.01    !  surface  buoyancy lenght scale minimum value (0.04)
   ln_lc       = .true.    !  Langmuir cell parameterisation (Axell 2002)
   rn_lc       =   0.15    !  coef. associated to Langmuir cells
   nn_etau     =   1       !LOLO?  penetration of tke below the mixed layer (ML) due to internal & intertial waves
                           !        = 0 no penetration
                           !        = 1 add a tke source below the ML
                           !        = 2 add a tke source just at the base of the ML
                           !        = 3 as = 1 applied on HF part of the stress    ("key_oasis3")
/
!-----------------------------------------------------------------------
&namzdf_ddm    !   double diffusive mixing parameterization             ("key_zdfddm")
!-----------------------------------------------------------------------
   rn_avts     = 1.e-4     !  maximum avs (vertical mixing on salinity)
   rn_hsbfr    = 1.6       !  heat/salt buoyancy flux ratio
/
!-----------------------------------------------------------------------
&namzdf_tmx    !   tidal mixing parameterization                        ("key_zdftmx")
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namzdf_tmx_new    !   new tidal mixing parameterization                ("key_zdftmx_new")
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namsol        !   elliptic solver / island / free surface
!-----------------------------------------------------------------------
   nn_solv     =      1    !  elliptic solver: =1 preconditioned conjugate gradient (pcg)
                           !                   =2 successive-over-relaxation (sor)
   nn_sol_arp  =      0    !  absolute/relative (0/1) precision convergence test
   rn_eps      =  1.e-6    !  absolute precision of the solver
   nn_nmin     =    300    !  minimum of iterations for the SOR solver
   nn_nmax     =   2800    !  maximum of iterations for the SOR solver
   nn_nmod     =     10    !  frequency of test for the SOR solver
   rn_resmax   =  1.e-10   !  absolute precision for the SOR solver
   rn_sor      =  1.973    !  optimal coefficient for SOR solver (to be adjusted with the domain)
/
!-----------------------------------------------------------------------
&nammpp        !   Massively Parallel Processing                        ("key_mpp_mpi)
!-----------------------------------------------------------------------
jpni        =   <JPNI>  !  jpni   number of processors following i (set automatically if < 1)
jpnj        =   <JPNJ>  !  jpnj   number of processors following j (set automatically if < 1)
jpnij       =   <JPNIJ> !  jpnij  number of local domains (set automatically if < 1)
/
!-----------------------------------------------------------------------
&namctl        !   Control prints & Benchmark
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namptr       !   Poleward Transport Diagnostic
!-----------------------------------------------------------------------
   ln_diaptr  = .false.    !  Poleward heat and salt transport (T) or not (F)
   ln_subbas  = .false.     !  Atlantic/Pacific/Indian basins computation (T) or not
/
!-----------------------------------------------------------------------
&namhsb       !  Heat and salt budgets
!-----------------------------------------------------------------------
   ln_diahsb  = .false.  
/
!-----------------------------------------------------------------------
&namdyn_nept  !   Neptune effect (simplified: lateral and vertical diffusions removed)
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namzdf_gls                !   GLS vertical diffusion                   ("key_zdfgls")
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namtrd        !   diagnostics on dynamics and/or tracer trends
!              !       and/or mixed-layer trends and/or barotropic vorticity
!-----------------------------------------------------------------------
/
!-----------------------------------------------------------------------
&namsto       ! Stochastic parametrization of EOS
!-----------------------------------------------------------------------
/
