
#define MANGLED_NESC_APP_C
#define nx_struct struct
#define nx_union union
#define dbg(mode, format) ((void)0)
#define dbg_clear(mode, format) ((void)0)
#define dbg_active(mode) 0
//# 8 "/opt/emdoor/tos/chips/cc2430/mcs51/keil_stdint.h"
typedef signed char int8_t;
typedef short int16_t;



typedef long int32_t;







typedef unsigned char uint8_t;
typedef unsigned short uint16_t;



typedef unsigned long uint32_t;



//# 19 "/opt/emdoor/tos/chips/cc2430/mcs51/stdint.h"
typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef long int_least32_t;



/*__extension__*/ 
typedef long  int int_least64_t;



typedef unsigned char uint_least8_t;
typedef unsigned short uint_least16_t;
typedef unsigned long uint_least32_t;



/*__extension__*/ 
typedef unsigned long  int uint_least64_t;






typedef signed char int_fast8_t;





typedef int int_fast16_t;
typedef int int_fast32_t;
/*__extension__*/ 
typedef long  int int_fast64_t;



typedef unsigned char uint_fast8_t;





typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
/*__extension__*/ 
typedef unsigned long  int uint_fast64_t;
//# 79 "/opt/emdoor/tos/chips/cc2430/mcs51/stdint.h" 3
typedef int intptr_t;


typedef unsigned int uintptr_t;








/*__extension__*/ 
typedef long  int intmax_t;
/*__extension__*/ 
typedef unsigned long  int uintmax_t;
//# 231 "/usr/include/inttypes.h"
//#line 228
typedef struct __nesc_unnamed4242 {
  intmax_t quot;
  intmax_t rem;
} imaxdiv_t;
//# 385 "/usr/lib/ncc/nesc_nx.h"
typedef struct { char _data[1]; } /*__attribute__((packed))*/ nx_int8_t;typedef int8_t __nesc_nxbase_nx_int8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nx_int16_t;typedef int16_t __nesc_nxbase_nx_int16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nx_int32_t;typedef int32_t __nesc_nxbase_nx_int32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nx_int64_t;typedef int32_t __nesc_nxbase_nx_int64_t  ;
typedef struct { char _data[1]; } /*__attribute__((packed))*/ nx_uint8_t;typedef uint8_t __nesc_nxbase_nx_uint8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nx_uint16_t;typedef uint16_t __nesc_nxbase_nx_uint16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nx_uint32_t;typedef uint32_t __nesc_nxbase_nx_uint32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nx_uint64_t;typedef uint32_t __nesc_nxbase_nx_uint64_t  ;


typedef struct { char _data[1]; } /*__attribute__((packed))*/ nxle_int8_t;typedef int8_t __nesc_nxbase_nxle_int8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nxle_int16_t;typedef int16_t __nesc_nxbase_nxle_int16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nxle_int32_t;typedef int32_t __nesc_nxbase_nxle_int32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nxle_int64_t;typedef int32_t __nesc_nxbase_nxle_int64_t  ;
typedef struct { char _data[1]; } /*__attribute__((packed))*/ nxle_uint8_t;typedef uint8_t __nesc_nxbase_nxle_uint8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nxle_uint16_t;typedef uint16_t __nesc_nxbase_nxle_uint16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nxle_uint32_t;typedef uint32_t __nesc_nxbase_nxle_uint32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nxle_uint64_t;typedef uint32_t __nesc_nxbase_nxle_uint64_t  ;
//# 26 "/usr/include/machine/_types.h"
typedef signed char __int8_t;
typedef unsigned char __uint8_t;








typedef signed short __int16_t;
typedef unsigned short __uint16_t;








typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
//# 58 "/usr/include/machine/_types.h" 3
typedef signed int __int32_t;
typedef unsigned int __uint32_t;
//#line 76
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
//#line 99
typedef signed long  __int64_t;
typedef unsigned long  __uint64_t;
//# 14 "/usr/include/sys/lock.h"
typedef void *_LOCK_T;
//# 14 "/usr/include/sys/_types.h"
typedef long _off_t;
/*__extension__*/ 
//#line 15
typedef long  _off64_t;


typedef int _ssize_t;
//# 354 "/usr/lib/gcc/i686-pc-cygwin/3.4.4/include/stddef.h" 3
typedef unsigned int wint_t;
//# 35 "/usr/include/sys/_types.h"
//#line 27
typedef struct __nesc_unnamed4243 {

  int __count;
  union __nesc_unnamed4244 {

    wint_t __wch;
    unsigned char __wchb[4];
  } __value;
} _mbstate_t;

typedef _LOCK_T _flock_t;


typedef void *_iconv_t;
//# 151 "/usr/lib/gcc/i686-pc-cygwin/3.4.4/include/stddef.h" 3
typedef int ptrdiff_t;
//#line 213
typedef unsigned int size_t;
//#line 325
typedef short unsigned int wchar_t;
//# 19 "/usr/include/machine/types.h"
typedef long int __off_t;
typedef int __pid_t;

/*__extension__*/ 
//#line 22
typedef long  int __loff_t;
//# 92 "/usr/include/sys/types.h"
typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;
typedef unsigned long u_long;



typedef unsigned short ushort;
typedef unsigned int uint;



typedef unsigned long clock_t;




typedef long time_t;




struct timespec {
  time_t tv_sec;
  long tv_nsec;
};

struct itimerspec {
  struct timespec it_interval;
  struct timespec it_value;
};


typedef long daddr_t;
typedef char *caddr_t;
//# 180 "/usr/include/sys/types.h" 3
typedef int pid_t;



typedef _ssize_t ssize_t;
//#line 203
typedef unsigned short nlink_t;
//#line 225
typedef long fd_mask;









//#line 233
typedef struct _types_fd_set {
  fd_mask fds_bits[(64 + (sizeof(fd_mask ) * 8 - 1)) / (sizeof(fd_mask ) * 8)];
} _types_fd_set;
//#line 256
typedef unsigned long clockid_t;




typedef unsigned long timer_t;



typedef unsigned long useconds_t;
typedef long suseconds_t;
//# 26 "/usr/include/cygwin/types.h"
typedef struct timespec timespec_t;




typedef struct timespec timestruc_t;





typedef _off64_t off_t;





typedef __loff_t loff_t;



typedef short __dev16_t;
typedef unsigned long __dev32_t;

typedef __dev32_t dev_t;







typedef long blksize_t;




typedef long __blkcnt32_t;
typedef long  __blkcnt64_t;

typedef __blkcnt64_t blkcnt_t;







typedef unsigned long fsblkcnt_t;




typedef unsigned long fsfilcnt_t;




typedef unsigned short __uid16_t;
typedef unsigned long __uid32_t;

typedef __uid32_t uid_t;







typedef unsigned short __gid16_t;
typedef unsigned long __gid32_t;

typedef __gid32_t gid_t;







typedef unsigned long __ino32_t;
typedef unsigned long  __ino64_t;

typedef __ino64_t ino_t;








typedef unsigned long id_t;
//# 140 "/usr/include/cygwin/types.h" 3
struct flock {
  short l_type;
  short l_whence;
  off_t l_start;
  off_t l_len;

  pid_t l_pid;
};







typedef long  key_t;







typedef unsigned long vm_offset_t;




typedef unsigned long vm_size_t;




typedef void *vm_object_t;




typedef unsigned char u_int8_t;



typedef __uint16_t u_int16_t;



typedef __uint32_t u_int32_t;



typedef __uint64_t u_int64_t;




typedef __int32_t register_t;




typedef char *addr_t;




typedef unsigned mode_t;





typedef struct __pthread_t {
//#line 211
  char __dummy;
} *
//#line 211
pthread_t;
typedef struct __pthread_mutex_t {
//#line 212
  char __dummy;
} *
//#line 212
pthread_mutex_t;

typedef struct __pthread_key_t {
//#line 214
  char __dummy;
} *
//#line 214
pthread_key_t;
typedef struct __pthread_attr_t {
//#line 215
  char __dummy;
} *
//#line 215
pthread_attr_t;
typedef struct __pthread_mutexattr_t {
//#line 216
  char __dummy;
} *
//#line 216
pthread_mutexattr_t;
typedef struct __pthread_condattr_t {
//#line 217
  char __dummy;
} *
//#line 217
pthread_condattr_t;
typedef struct __pthread_cond_t {
//#line 218
  char __dummy;
} *
//#line 218
pthread_cond_t;







//#line 221
typedef struct __nesc_unnamed4245 {

  pthread_mutex_t mutex;
  int state;
} 
pthread_once_t;
typedef struct __pthread_rwlock_t {
//#line 227
  char __dummy;
} *
//#line 227
pthread_rwlock_t;
typedef struct __pthread_rwlockattr_t {
//#line 228
  char __dummy;
} *
//#line 228
pthread_rwlockattr_t;
//# 9 "/opt/emdoor/tos/chips/cc2430/mcs51/string.h"
extern void *memset(void *s, char val, int n);
//# 11 "/opt/emdoor/tos/chips/cc2430/mcs51/stdlib.h"
typedef int (*__compar_fn_t)(const void *, const void *);
//# 19 "/usr/include/sys/reent.h"
typedef unsigned long __ULong;
//# 40 "/usr/include/sys/reent.h" 3
struct _Bigint {

  struct _Bigint *_next;
  int _k, _maxwds, _sign, _wds;
  __ULong _x[1];
};


struct __tm {

  int __tm_sec;
  int __tm_min;
  int __tm_hour;
  int __tm_mday;
  int __tm_mon;
  int __tm_year;
  int __tm_wday;
  int __tm_yday;
  int __tm_isdst;
};







struct _on_exit_args {
  void *_fnargs[32];
  void *_dso_handle[32];

  __ULong _fntypes;


  __ULong _is_cxa;
};









struct _atexit {
  struct _atexit *_next;
  int _ind;

  void (*_fns[32])(void );
  struct _on_exit_args _on_exit_args;
};









struct __sbuf {
  unsigned char *_base;
  int _size;
};






typedef long _fpos_t;



typedef _off64_t _fpos64_t;
//#line 166
struct __sFILE {
  unsigned char *_p;
  int _r;
  int _w;
  short _flags;
  short _file;
  struct __sbuf _bf;
  int _lbfsize;






  void *_cookie;

  _ssize_t /*__attribute((__cdecl__))*/ (*_read)(void *_cookie, char *_buf, int _n);
  _ssize_t /*__attribute((__cdecl__))*/ (*_write)(void *_cookie, const char *_buf, int _n);

  _fpos_t /*__attribute((__cdecl__))*/ (*_seek)(void *_cookie, _fpos_t _offset, int _whence);
  int /*__attribute((__cdecl__))*/ (*_close)(void *_cookie);


  struct __sbuf _ub;
  unsigned char *_up;
  int _ur;


  unsigned char _ubuf[3];
  unsigned char _nbuf[1];


  struct __sbuf _lb;


  int _blksize;
  int _offset;


  struct _reent *__data;



  _flock_t _lock;
};



struct __sFILE64 {
  unsigned char *_p;
  int _r;
  int _w;
  short _flags;
  short _file;
  struct __sbuf _bf;
  int _lbfsize;

  struct _reent *__data;


  void *_cookie;

  _ssize_t /*__attribute((__cdecl__))*/ (*_read)(void *_cookie, char *_buf, int _n);
  _ssize_t /*__attribute((__cdecl__))*/ (*_write)(void *_cookie, const char *_buf, int _n);

  _fpos_t /*__attribute((__cdecl__))*/ (*_seek)(void *_cookie, _fpos_t _offset, int _whence);
  int /*__attribute((__cdecl__))*/ (*_close)(void *_cookie);


  struct __sbuf _ub;
  unsigned char *_up;
  int _ur;


  unsigned char _ubuf[3];
  unsigned char _nbuf[1];


  struct __sbuf _lb;


  int _blksize;
  int _flags2;

  _off64_t _offset;
  _fpos64_t /*__attribute((__cdecl__))*/ (*_seek64)(void *_cookie, _fpos64_t _offset, int _whence);


  _flock_t _lock;
};

typedef struct __sFILE64 __FILE;




struct _glue {

  struct _glue *_next;
  int _niobs;
  __FILE *_iobs;
};
//#line 290
struct _rand48 {
  unsigned short _seed[3];
  unsigned short _mult[3];
  unsigned short _add;
};
//#line 565
struct _reent {

  int _errno;




  __FILE *_stdin, *_stdout, *_stderr;

  int _inc;
  char _emergency[25];

  int _current_category;
  const char *_current_locale;

  int __sdidinit;

  void /*__attribute((__cdecl__))*/ (*__cleanup)(struct _reent *);


  struct _Bigint *_result;
  int _result_k;
  struct _Bigint *_p5s;
  struct _Bigint **_freelist;


  int _cvtlen;
  char *_cvtbuf;

  union __nesc_unnamed4246 {

    struct __nesc_unnamed4247 {

      unsigned int _unused_rand;
      char *_strtok_last;
      char _asctime_buf[26];
      struct __tm _localtime_buf;
      int _gamma_signgam;
      /*__extension__*/ unsigned long  _rand_next;
      struct _rand48 _r48;
      _mbstate_t _mblen_state;
      _mbstate_t _mbtowc_state;
      _mbstate_t _wctomb_state;
      char _l64a_buf[8];
      char _signal_buf[24];
      int _getdate_err;
      _mbstate_t _mbrlen_state;
      _mbstate_t _mbrtowc_state;
      _mbstate_t _mbsrtowcs_state;
      _mbstate_t _wcrtomb_state;
      _mbstate_t _wcsrtombs_state;
    } _reent;



    struct __nesc_unnamed4248 {


      unsigned char *_nextf[30];
      unsigned int _nmalloc[30];
    } _unused;
  } _new;


  struct _atexit *_atexit;
  struct _atexit _atexit0;


  void (**_sig_func)(int );




  struct _glue __sglue;
  __FILE __sf[3];
};
//#line 799
struct _reent;
struct _reent;









struct _reent;
//# 11 "/usr/include/math.h"
union __dmath {

  __ULong i[2];
  double d;
};

union __fmath {

  __ULong i[1];
  float f;
};

union __ldmath {

  __ULong i[4];
  long double ld;
};
//# 111 "/usr/include/math.h" 3
typedef float float_t;
typedef double double_t;
//#line 344
struct exception {


  int type;
  char *name;
  double arg1;
  double arg2;
  double retval;
  int err;
};
//#line 399
enum __fdlibm_version {

  __fdlibm_ieee = -1, 
  __fdlibm_svid, 
  __fdlibm_xopen, 
  __fdlibm_posix
};




enum __fdlibm_version;
//# 20 "/opt/emdoor/tos/system/tos.h"
typedef uint8_t bool  ;
enum __nesc_unnamed4249 {
//#line 21
  FALSE = 0, TRUE = 1
};









typedef nx_int8_t nx_bool;
uint16_t TOS_NODE_ID = 0xFEFE;





/*struct __nesc_attr_atmostonce {
};*/
//#line 40
/*struct __nesc_attr_atleastonce {
};*/
//#line 41
/*struct __nesc_attr_exactlyonce {
};*/
//# 6 "/opt/emdoor/tos/types/AM.h"
typedef nx_uint8_t nx_am_id_t;
typedef nx_uint8_t nx_am_group_t;
typedef nx_uint16_t nx_am_addr_t;

typedef uint8_t am_id_t;
typedef uint8_t am_group_t;
typedef uint16_t am_addr_t;

enum __nesc_unnamed4250 {
  AM_BROADCAST_ADDR = 0xffff
};









enum __nesc_unnamed4251 {
  TOS_AM_GROUP = 0x22, 
  TOS_AM_ADDRESS = 1
};
//# 17 "/opt/emdoor/tos/platforms/zigbem/platform.h"
uint16_t TOS_IEEE_SADDR = TOS_AM_ADDRESS;
uint16_t TOS_IEEE_PANID = TOS_AM_GROUP;
//# 3 "/opt/emdoor/tos/platforms/zigbem/platform_interrupt.h"
typedef uint8_t TPlatformIntUser;
typedef uint8_t TPlatformIntOSA;
//# 34 "/opt/emdoor/tos/types/TinyError.h"
enum __nesc_unnamed4252 {
  SUCCESS = 0, 
  FAIL = 1, 
  ESIZE = 2, 
  ECANCEL = 3, 
  EOFF = 4, 
  EBUSY = 5, 
  EINVAL = 6, 
  ERETRY = 7, 
  ERESERVE = 8, 
  EALREADY = 9
};

typedef uint8_t error_t  ;
//# 64 "/opt/emdoor/tos/chips/cc2430/mcs51/io8051.h"
sfr PCON = 0x87;
//#line 143
sbit EA = 0xAF;
//#line 158
sbit P0_1 = 0x81;
//#line 177
sbit P1_0 = 0x90;
sbit P1_1 = 0x91;
sbit P1_2 = 0x92;
sbit P1_3 = 0x93;
sbit P1_4 = 0x94;
//#line 193
sbit P2_0 = 0xA0;
//# 56 "/opt/emdoor/tos/chips/cc2430/ioCC2430.h"
enum __nesc_unnamed4253 {
  CC2430_IEN0_EA = 0x7, 
  CC2430_IEN0_STIE = 0x5, 
  CC2430_IEN0_ENCIE = 0x4, 
  CC2430_IEN0_URX1IE = 0x3, 
  CC2430_IEN0_URX0IE = 0x2, 
  CC2430_IEN0_ADCIE = 0x1, 
  CC2430_IEN0_RFERRIE = 0x0
};





enum __nesc_unnamed4254 {
  CC2430_IEN2_WDTIE = 0x5, 
  CC2430_IEN2_P1IE = 0x4, 
  CC2430_IEN2_UTX1IE = 0x3, 
  CC2430_IEN2_UTX0IE = 0x2, 
  CC2430_IEN2_P2IE = 0x1, 
  CC2430_IEN2_RFIE = 0x0
};





enum __nesc_unnamed4255 {
  CC2430_IRCON_STIF = 0x7, 
  CC2430_IRCON_P0IF = 0x5, 
  CC2430_IRCON_T4IF = 0x4, 
  CC2430_IRCON_T3IF = 0x3, 
  CC2430_IRCON_T2IF = 0x2, 
  CC2430_IRCON_T1IF = 0x1, 
  CC2430_IRCON_DMAIF = 0x0
};





enum __nesc_unnamed4256 {
  CC2430_IRCON2_WDTIF = 0x4, 
  CC2430_IRCON2_P1IF = 0x3, 
  CC2430_IRCON2_UTX1IF = 0x2, 
  CC2430_IRCON2_UTX0IF = 0x1, 
  CC2430_IRCON2_P2IF = 0x0
};





enum __nesc_unnamed4257 {
  CC2430_RFIM_RREG_PD = 0x7, 
  CC2430_RFIM_TXDONE = 0x6, 
  CC2430_RFIM_FIFOP = 0x5, 
  CC2430_RFIM_SFD = 0x4, 
  CC2430_RFIM_CCA = 0x3, 
  CC2430_RFIM_CSP_WT = 0x2, 
  CC2430_RFIM_CSP_STOP = 0x1, 
  CC2430_RFIM_CSP_INT = 0x0
};





enum __nesc_unnamed4258 {
  CC2430_RFIF_RREG_ON = 0x7, 
  CC2430_RFIF_TXDONE = 0x6, 
  CC2430_RFIF_FIFOP = 0x5, 
  CC2430_RFIF_SFD = 0x4, 
  CC2430_RFIF_CCA = 0x3, 
  CC2430_RFIF_CSP_WT = 0x2, 
  CC2430_RFIF_CSP_STOP = 0x1, 
  CC2430_RFIF_CSP_INT = 0x0
};
//#line 246
sfr SLEEP = 0xBE;
//#line 262
sfr CLKCON = 0xC6;
sfr MEMCTR = 0xC7;
//#line 350
sfr P0_DIR = 0xFD;
sfr P1_DIR = 0xFE;
sfr P2_DIR = 0xFF;
//#line 392
//typedef uint16_t uint16_t _data;
//typedef uint8_t uint8_t _data;

//typedef uint16_t uint16_t xdata;
//typedef uint8_t uint8_t xdata;

//typedef uint16_t uint16_t code;
//typedef uint8_t uint8_t code;


//typedef uint32_t uint32_t_xdata_pm0;
//typedef uint16_t uint16_t xdata_pm0;
//typedef uint8_t uint8_t xdata_pm0;
//# 42 "/opt/emdoor/tos/chips/cc2430/radio/CC2420.h"
typedef uint8_t cc2420_status_t;
//#line 67
//#line 48
typedef nx_struct cc2420_header_t {
  nxle_uint8_t length;
  nxle_uint16_t fcf;
  nxle_uint8_t dsn;
  nxle_uint16_t destpan;
  nxle_uint16_t dest;
  nxle_uint16_t src;






  nxle_uint8_t type;


  nx_am_group_t group;
} /*__attribute__((packed))*/ 

cc2420_header_t;







//#line 72
typedef nx_struct cc2420_footer_t {

  nxle_uint8_t i;
} /*__attribute__((packed))*/ cc2420_footer_t;
//#line 96
//#line 81
typedef nx_struct cc2420_meta_data_t {
  nx_uint8_t tx_power;
  nx_uint8_t rssi;
  nx_uint8_t lqi;
  nx_bool crc;
  nx_bool ack;
  nx_uint16_t time;
  nx_uint16_t rxInterval;
} /*__attribute__((packed))*/ 






cc2420_meta_data_t;






//#line 99
typedef nx_struct cc2420_packet_t {
  cc2420_header_t packet;

  nx_uint8_t _data[42];
} /*__attribute__((packed))*/ cc2420_packet_t;
//#line 134
enum __nesc_unnamed4259 {

  MAC_HEADER_SIZE = sizeof(cc2420_header_t ) - 1, 

  MAC_FOOTER_SIZE = sizeof(uint16_t ), 

  MAC_PROTOCOL_SIZE = MAC_HEADER_SIZE + MAC_FOOTER_SIZE, 

  MAC_PACKET_SIZE = MAC_HEADER_SIZE + 114 + MAC_FOOTER_SIZE
};

enum cc2420_enums {
  CC2420_TIME_ACK_TURNAROUND = 7, 
  CC2420_TIME_VREN = 20, 
  CC2420_TIME_SYMBOL = 2, 
  CC2420_BACKOFF_PERIOD = 20 / CC2420_TIME_SYMBOL, 
  CC2420_MIN_BACKOFF = 20 / CC2420_TIME_SYMBOL, 
  CC2420_ACK_WAIT_DELAY = 256, 
  CC2420_TXDONE_PERIOD = 128
};

enum cc2420_status_enums {
  CC2420_STATUS_RSSI_VALID = 1 << 1, 
  CC2420_STATUS_LOCK = 1 << 2, 
  CC2420_STATUS_TX_ACTIVE = 1 << 3, 
  CC2420_STATUS_ENC_BUSY = 1 << 4, 
  CC2420_STATUS_TX_UNDERFLOW = 1 << 5, 
  CC2420_STATUS_XOSC16M_STABLE = 1 << 6
};

enum cc2420_config_reg_enums {
  CC2420_SNOP = 0x00, 
  CC2420_SXOSCON = 0x01, 
  CC2420_STXCAL = 0x02, 
  CC2420_SRXON = 0x03, 
  CC2420_STXON = 0x04, 
  CC2420_STXONCCA = 0x05, 
  CC2420_SRFOFF = 0x06, 
  CC2420_SXOSCOFF = 0x07, 
  CC2420_SFLUSHRX = 0x08, 
  CC2420_SFLUSHTX = 0x09, 
  CC2420_SACK = 0x0a, 
  CC2420_SACKPEND = 0x0b, 
  CC2420_SRXDEC = 0x0c, 
  CC2420_STXENC = 0x0d, 
  CC2420_SAES = 0x0e, 
  CC2420_MAIN = 0x10, 
  CC2420_MDMCTRL0 = 0x11, 
  CC2420_MDMCTRL1 = 0x12, 
  CC2420_RSSI = 0x13, 
  CC2420_SYNCWORD = 0x14, 
  CC2420_TXCTRL = 0x15, 
  CC2420_RXCTRL0 = 0x16, 
  CC2420_RXCTRL1 = 0x17, 
  CC2420_FSCTRL = 0x18, 
  CC2420_SECCTRL0 = 0x19, 
  CC2420_SECCTRL1 = 0x1a, 
  CC2420_BATTMON = 0x1b, 
  CC2420_IOCFG0 = 0x1c, 
  CC2420_IOCFG1 = 0x1d, 
  CC2420_MANFIDL = 0x1e, 
  CC2420_MANFIDH = 0x1f, 
  CC2420_FSMTC = 0x20, 
  CC2420_MANAND = 0x21, 
  CC2420_MANOR = 0x22, 
  CC2420_AGCCTRL = 0x23, 
  CC2420_AGCTST0 = 0x24, 
  CC2420_AGCTST1 = 0x25, 
  CC2420_AGCTST2 = 0x26, 
  CC2420_FSTST0 = 0x27, 
  CC2420_FSTST1 = 0x28, 
  CC2420_FSTST2 = 0x29, 
  CC2420_FSTST3 = 0x2a, 
  CC2420_RXBPFTST = 0x2b, 
  CC2420_FMSTATE = 0x2c, 
  CC2420_ADCTST = 0x2d, 
  CC2420_DACTST = 0x2e, 
  CC2420_TOPTST = 0x2f, 
  CC2420_TXFIFO = 0x3e, 
  CC2420_RXFIFO = 0x3f
};

enum cc2420_ram_addr_enums {
  CC2420_RAM_TXFIFO = 0x000, 
  CC2420_RAM_RXFIFO = 0x080, 
  CC2420_RAM_KEY0 = 0x100, 
  CC2420_RAM_RXNONCE = 0x110, 
  CC2420_RAM_SABUF = 0x120, 
  CC2420_RAM_KEY1 = 0x130, 
  CC2420_RAM_TXNONCE = 0x140, 
  CC2420_RAM_CBCSTATE = 0x150, 
  CC2420_RAM_IEEEADR = 0x160, 
  CC2420_RAM_PANID = 0x168, 
  CC2420_RAM_SHORTADR = 0x16a
};

enum cc2420_nonce_enums {
  CC2420_NONCE_BLOCK_COUNTER = 0, 
  CC2420_NONCE_KEY_SEQ_COUNTER = 2, 
  CC2420_NONCE_FRAME_COUNTER = 3, 
  CC2420_NONCE_SOURCE_ADDRESS = 7, 
  CC2420_NONCE_FLAGS = 15
};

enum cc2420_main_enums {
  CC2420_MAIN_RESETn = 15, 
  CC2420_MAIN_ENC_RESETn = 14, 
  CC2420_MAIN_DEMOD_RESETn = 13, 
  CC2420_MAIN_MOD_RESETn = 12, 
  CC2420_MAIN_FS_RESETn = 11, 
  CC2420_MAIN_XOSC16M_BYPASS = 0
};

enum cc2420_mdmctrl0_enums {
  CC2420_MDMCTRL0_RESERVED_FRAME_MODE = 13, 
  CC2420_MDMCTRL0_PAN_COORDINATOR = 12, 
  CC2420_MDMCTRL0_ADR_DECODE = 11, 
  CC2420_MDMCTRL0_CCA_HYST = 8, 
  CC2420_MDMCTRL0_CCA_MOD = 6, 
  CC2420_MDMCTRL0_AUTOCRC = 5, 
  CC2420_MDMCTRL0_AUTOACK = 4, 
  CC2420_MDMCTRL0_PREAMBLE_LENGTH = 0
};

enum cc2420_mdmctrl1_enums {
  CC2420_MDMCTRL1_CORR_THR = 6, 
  CC2420_MDMCTRL1_DEMOD_AVG_MODE = 5, 
  CC2420_MDMCTRL1_MODULATION_MODE = 4, 
  CC2420_MDMCTRL1_TX_MODE = 2, 
  CC2420_MDMCTRL1_RX_MODE = 0
};

enum cc2420_rssi_enums {
  CC2420_RSSI_CCA_THR = 8, 
  CC2420_RSSI_RSSI_VAL = 0
};

enum cc2420_syncword_enums {
  CC2420_SYNCWORD_SYNCWORD = 0
};

enum cc2420_txctrl_enums {
  CC2420_TXCTRL_TXMIXBUF_CUR = 14, 
  CC2420_TXCTRL_TX_TURNAROUND = 13, 
  CC2420_TXCTRL_TXMIX_CAP_ARRAY = 11, 
  CC2420_TXCTRL_TXMIX_CURRENT = 9, 
  CC2420_TXCTRL_PA_CURRENT = 6, 
  CC2420_TXCTRL_RESERVED = 5, 
  CC2420_TXCTRL_PA_LEVEL = 0
};

enum cc2420_rxctrl0_enums {
  CC2420_RXCTRL0_RXMIXBUF_CUR = 12, 
  CC2420_RXCTRL0_HIGH_LNA_GAIN = 10, 
  CC2420_RXCTRL0_MED_LNA_GAIN = 8, 
  CC2420_RXCTRL0_LOW_LNA_GAIN = 6, 
  CC2420_RXCTRL0_HIGH_LNA_CURRENT = 4, 
  CC2420_RXCTRL0_MED_LNA_CURRENT = 2, 
  CC2420_RXCTRL0_LOW_LNA_CURRENT = 0
};

enum cc2420_rxctrl1_enums {
  CC2420_RXCTRL1_RXBPF_LOCUR = 13, 
  CC2420_RXCTRL1_RXBPF_MIDCUR = 12, 
  CC2420_RXCTRL1_LOW_LOWGAIN = 11, 
  CC2420_RXCTRL1_MED_LOWGAIN = 10, 
  CC2420_RXCTRL1_HIGH_HGM = 9, 
  CC2420_RXCTRL1_MED_HGM = 8, 
  CC2420_RXCTRL1_LNA_CAP_ARRAY = 6, 
  CC2420_RXCTRL1_RXMIX_TAIL = 4, 
  CC2420_RXCTRL1_RXMIX_VCM = 2, 
  CC2420_RXCTRL1_RXMIX_CURRENT = 0
};

enum cc2420_rsctrl_enums {
  CC2420_FSCTRL_LOCK_THR = 14, 
  CC2420_FSCTRL_CAL_DONE = 13, 
  CC2420_FSCTRL_CAL_RUNNING = 12, 
  CC2420_FSCTRL_LOCK_LENGTH = 11, 
  CC2420_FSCTRL_LOCK_STATUS = 10, 
  CC2420_FSCTRL_FREQ = 0
};

enum cc2420_secctrl0_enums {
  CC2420_SECCTRL0_RXFIFO_PROTECTION = 9, 
  CC2420_SECCTRL0_SEC_CBC_HEAD = 8, 
  CC2420_SECCTRL0_SEC_SAKEYSEL = 7, 
  CC2420_SECCTRL0_SEC_TXKEYSEL = 6, 
  CC2420_SECCTRL0_SEC_RXKEYSEL = 5, 
  CC2420_SECCTRL0_SEC_M = 2, 
  CC2420_SECCTRL0_SEC_MODE = 0
};

enum cc2420_secctrl1_enums {
  CC2420_SECCTRL1_SEC_TXL = 8, 
  CC2420_SECCTRL1_SEC_RXL = 0
};

enum cc2420_battmon_enums {
  CC2420_BATTMON_BATT_OK = 6, 
  CC2420_BATTMON_BATTMON_EN = 5, 
  CC2420_BATTMON_BATTMON_VOLTAGE = 0
};

enum cc2420_iocfg0_enums {
  CC2420_IOCFG0_BCN_ACCEPT = 11, 
  CC2420_IOCFG0_FIFO_POLARITY = 10, 
  CC2420_IOCFG0_FIFOP_POLARITY = 9, 
  CC2420_IOCFG0_SFD_POLARITY = 8, 
  CC2420_IOCFG0_CCA_POLARITY = 7, 
  CC2420_IOCFG0_FIFOP_THR = 0
};

enum cc2420_iocfg1_enums {
  CC2420_IOCFG1_HSSD_SRC = 10, 
  CC2420_IOCFG1_SFDMUX = 5, 
  CC2420_IOCFG1_CCAMUX = 0
};

enum cc2420_manfidl_enums {
  CC2420_MANFIDL_PARTNUM = 12, 
  CC2420_MANFIDL_MANFID = 0
};

enum cc2420_manfidh_enums {
  CC2420_MANFIDH_VERSION = 12, 
  CC2420_MANFIDH_PARTNUM = 0
};

enum cc2420_fsmtc_enums {
  CC2420_FSMTC_TC_RXCHAIN2RX = 13, 
  CC2420_FSMTC_TC_SWITCH2TX = 10, 
  CC2420_FSMTC_TC_PAON2TX = 6, 
  CC2420_FSMTC_TC_TXEND2SWITCH = 3, 
  CC2420_FSMTC_TC_TXEND2PAOFF = 0
};

enum cc2420_sfdmux_enums {
  CC2420_SFDMUX_SFD = 0, 
  CC2420_SFDMUX_XOSC16M_STABLE = 24
};
//# 10 "/opt/emdoor/tos/platforms/zigbem/platform_message.h"
//#line 7
typedef union message_header {
  cc2420_header_t cc2420;
} 
message_header_t;



//#line 12
typedef union TOSRadioFooter {
  cc2420_footer_t cc2420;
} message_footer_t;



//#line 16
typedef union TOSRadioMeta_data {
  cc2420_meta_data_t cc2420;
} message_meta_data_t;
//# 19 "/opt/emdoor/tos/types/message.h"
//#line 14
typedef nx_struct message_t {
  nx_uint8_t header[sizeof(message_header_t )];
  nx_uint8_t _data[114];
  nx_uint8_t footer[sizeof(message_footer_t )];
  nx_uint8_t meta_data[sizeof(message_meta_data_t )];
} /*__attribute__((packed))*/ message_t;
//# 407 "/opt/emdoor/tos/chips/cc2430/ioCC2430.h"
typedef message_t message_t_xdata_pm0;
//#line 494
enum __nesc_unnamed4260 {
  CC2430_RFPWR_ADI_RADIO_PD = 0x4, 
  CC2430_RFPWR_RREG_RADIO_PD = 0x3, 
  CC2430_RFPWR_RREG_DELAY = 0x0, 
  CC2430_RFPWR_RREG_DELAY_MASK = 0x7
};

enum __nesc_unnamed4261 {
  CC2430_RREG_DELAY_0 = 0x0, 
  CC2430_RREG_DELAY_31 = 0x1, 
  CC2430_RREG_DELAY_63 = 0x2, 
  CC2430_RREG_DELAY_125 = 0x3, 
  CC2430_RREG_DELAY_250 = 0x4, 
  CC2430_RREG_DELAY_500 = 0x5, 
  CC2430_RREG_DELAY_1000 = 0x6, 
  CC2430_RREG_DELAY_2000 = 0x7
};

enum __nesc_unnamed4262 {
  CC2430_MDMCTRL0L_AUTOCRC = 0x5, 
  CC2430_MDMCTRL0L_AUTOACK = 0x4
};

enum __nesc_unnamed4263 {
  CC2430_MDMCTRL0H_FRAME_FILT = 0x6, 
  CC2430_MDMCTRL0H_RESERVED_FRAME_MODE = 0x5, 
  CC2430_MDMCTRL0H_PAN_COORDINATOR = 0x4, 
  CC2430_MDMCTRL0H_ADDR_DECODE = 0x3, 
  CC2430_MDMCTRL0H_CCA_HYST = 0x0
};

enum __nesc_unnamed4264 {
  CC2430_RFSTATUS_TX_ACTIVE = 0x4, 
  CC2430_RFSTATUS_FIFO = 0x3, 
  CC2430_RFSTATUS_FIFOP = 0x2, 
  CC2430_RFSTATUS_SFD = 0x1, 
  CC2430_RFSTATUS_CCA = 0x0
};
//# 62 "/opt/emdoor/tos/chips/cc2430/mcs51/mcs51hardware.h"
typedef uint8_t __nesc_atomic_t;

static   /*inline*/   void __nesc_disable_interrupt(void);
static   /*inline*/   void __nesc_enable_interrupt(void);

  /*inline*/   __nesc_atomic_t __nesc_atomic_start(void )  ;





  /*inline*/   void __nesc_atomic_end(__nesc_atomic_t oldSreg)  ;
//# 66 "/opt/emdoor/tos/lib/zigbem/common/Emdebug.h"
uint8_t current_task_id = 255;
//# 39 "/opt/emdoor/tos/chips/cc2430/timer/CC2430Timer.h"
enum __nesc_unnamed4265 {
  CC2430_SLEEP_OSC32K_CALDIS = 7, 
  CC2430_SLEEP_XOSC_STB = 6, 
  CC2430_SLEEP_HFRC_STB = 5, 
  CC2430_SLEEP_DIV = 3, 
  CC2430_SLEEP_OSC_PD = 2, 
  CC2430_SLEEP_MODE = 0, 
  CC2430_SLEEP_MODE_MASK = 3
};

enum __nesc_unnamed4266 {
  CC2430_SLEEP_POWERMODE_0 = 0, 
  CC2430_SLEEP_POWERMODE_1 = 1, 
  CC2430_SLEEP_POWERMODE_2 = 2, 
  CC2430_SLEEP_POWERMODE_3 = 3
};

enum __nesc_unnamed4267 {
  CC2430_CLKCON_OSC32K = 7, 
  CC2430_CLKCON_OSC = 6, 
  CC2430_CLKCON_TICKSPD = 3, 
  CC2430_CLKCON_CLKSPD = 0, 
  CC2430_CLKCON_TICKSPD_MASK = 0x38
};




enum cc2430_tick_spd_t {
  CC2430_TICKF_DIV_1 = 0x0 << CC2430_CLKCON_TICKSPD, 
  CC2430_TICKF_DIV_2 = 0x1 << CC2430_CLKCON_TICKSPD, 
  CC2430_TICKF_DIV_4 = 0x2 << CC2430_CLKCON_TICKSPD, 
  CC2430_TICKF_DIV_8 = 0x3 << CC2430_CLKCON_TICKSPD, 
  CC2430_TICKF_DIV_16 = 0x4 << CC2430_CLKCON_TICKSPD, 
  CC2430_TICKF_DIV_32 = 0x5 << CC2430_CLKCON_TICKSPD, 
  CC2430_TICKF_DIV_64 = 0x6 << CC2430_CLKCON_TICKSPD, 
  CC2430_TICKF_DIV_128 = 0x7 << CC2430_CLKCON_TICKSPD
};










enum __nesc_unnamed4268 {
  CC2430_T1CTL_CH2IF = 0x7, 
  CC2430_T1CTL_CH1IF = 0x6, 
  CC2430_T1CTL_CH0IF = 0x5, 
  CC2430_T1CTL_OVFIF = 0x4, 
  CC2430_T1CTL_DIV = 0x2, 
  CC2430_T1CTL_MODE = 0x0, 
  CC2430_T1CTL_MODE_MASK = 0x3, 
  CC2430_T1CTL_DIV_MASK = 0xc, 
  CC2430_T1CTL_IF_MASK = 0xf0
};






enum cc2430_timer1_mode_t {
  CC2430_TIMER1_MODE_OFF = 0x0 << CC2430_T1CTL_MODE, 
  CC2430_TIMER1_MODE_FREE = 0x1 << CC2430_T1CTL_MODE, 
  CC2430_TIMER1_MODE_MODULO = 0x2 << CC2430_T1CTL_MODE, 
  CC2430_TIMER1_MODE_UPDOWN = 0x3 << CC2430_T1CTL_MODE
};






enum cc2430_timer1_if_t {
  CC2430_T1_CH2IF = 1 << CC2430_T1CTL_CH2IF, 
  CC2430_T1_CH1IF = 1 << CC2430_T1CTL_CH1IF, 
  CC2430_T1_CH0IF = 1 << CC2430_T1CTL_CH0IF, 
  CC2430_T1_OVFIF = 1 << CC2430_T1CTL_OVFIF
};





enum cc2430_timer1_prescaler_t {
  CC2430_TIMER1_DIV_1 = 0x0 << CC2430_T1CTL_DIV, 
  CC2430_TIMER1_DIV_8 = 0x1 << CC2430_T1CTL_DIV, 
  CC2430_TIMER1_DIV_32 = 0x2 << CC2430_T1CTL_DIV, 
  CC2430_TIMER1_DIV_128 = 0x3 << CC2430_T1CTL_DIV
};





enum __nesc_unnamed4269 {
  CC2430_T1CCTLx_CPSEL = 0x7, 
  CC2430_T1CCTLx_IM = 0x6, 
  CC2430_T1CCTLx_CMP = 0x3, 
  CC2430_T1CCTLx_MODE = 0x2, 
  CC2430_T1CCTLx_CAP = 0x0
};










enum cc2430_timerMAC_mode_t {
  CC2430_TIMERMAC_MODE_IDLE = 0x0, 
  CC2430_TIMERMAC_MODE_RUN = 0x1
};





enum cc2430_timerMAC_T2CNF_t {
  CC2430_T2CNF_CMPIF = 0x7, 
  CC2430_T2CNF_PERIF = 0x6, 
  CC2430_T2CNF_OFCMPIF = 0x5, 
  CC2430_T2CNF_CMSEL = 0x3, 
  CC2430_T2CNF_SYNC = 0x1, 
  CC2430_T2CNF_RUN = 0x0
};






enum cc2430_timerMAC_T2PEROF2_t {
  CC2430_T2PEROF2_CMPIM = 0x7, 
  CC2430_T2PEROF2_PERIM = 0x6, 
  CC2430_T2PEROF2_OFCMPIM = 0x5
};

enum cc2430_timerMAC_if_t {
  CC2430_TMAC_CMPIF = 1 << CC2430_T2CNF_CMPIF, 
  CC2430_TMAC_PERIF = 1 << CC2430_T2CNF_PERIF, 
  CC2430_TMAC_OFCMPIF = 1 << CC2430_T2CNF_OFCMPIF
};

enum cc2430_timerMAC_interval_t {
  CC2430_TIMERWDT_32768 = 0, 
  CC2430_TIMERWDT_8192 = 1, 
  CC2430_TIMERWDT_512 = 2, 
  CC2430_TIMERWDT_64 = 3
};
//#line 208
enum __nesc_unnamed4270 {
  CC2430_TIMIF_OVFIM = 0x6
};

enum cc2430_timer34_if_t {
  CC2430_TIMIF_T4CH1IF = 0x5, 
  CC2430_TIMIF_T4CH0IF = 0x4, 
  CC2430_TIMIF_T4OVFIF = 0x3, 
  CC2430_TIMIF_T3CH1IF = 0x2, 
  CC2430_TIMIF_T3CH0IF = 0x1, 
  CC2430_TIMIF_T3OVFIF = 0x0
};






enum cc2430_timer3_4_mode_t {
  CC2430_TIMER3_4_MODE_FREE = 0x0, 
  CC2430_TIMER3_4_MODE_DOWN = 0x1, 
  CC2430_TIMER3_4_MODE_MODULO = 0x2, 
  CC2430_TIMER3_4_MODE_UPDOWN = 0x3
};





enum __nesc_unnamed4271 {
  CC2430_T34CTL_DIV = 0x5, 
  CC2430_T34CTL_START = 0x4, 
  CC2430_T34CTL_OVFIM = 0x3, 
  CC2430_T34CTL_WDTIF = 0x3, 
  CC2430_T34CTL_CLR = 0x2, 
  CC2430_T34CTL_MODE = 0x0, 
  CC2430_T34CTL_MODE_MASK = 0x3, 
  CC2430_T34CTL_DIV_MASK = 0xe0
};





enum cc2430_timer3_4_prescaler_t {
  CC2430_TIMER3_4_DIV_1 = 0x0 << CC2430_T34CTL_DIV, 
  CC2430_TIMER3_4_DIV_2 = 0x1 << CC2430_T34CTL_DIV, 
  CC2430_TIMER3_4_DIV_4 = 0x2 << CC2430_T34CTL_DIV, 
  CC2430_TIMER3_4_DIV_8 = 0x3 << CC2430_T34CTL_DIV, 
  CC2430_TIMER3_4_DIV_16 = 0x4 << CC2430_T34CTL_DIV, 
  CC2430_TIMER3_4_DIV_32 = 0x5 << CC2430_T34CTL_DIV, 
  CC2430_TIMER3_4_DIV_64 = 0x6 << CC2430_T34CTL_DIV, 
  CC2430_TIMER3_4_DIV_128 = 0x7 << CC2430_T34CTL_DIV
};










enum __nesc_unnamed4272 {
  CC2430_WDCTL_CLR = 0x4, 
  CC2430_WDCTL_EN = 0x3, 
  CC2430_WDCTL_MODE = 0x2, 
  CC2430_WDCTL_INT = 0x0, 
  CC2430_WDCTL_INT_MASK = 0x3
};

enum cc2430_timerWDT_mode_t {
  CC2430_TIMERWDT_MODE_WDT = 0x0 << CC2430_WDCTL_MODE, 
  CC2430_TIMERWDT_MODE_TIMER = 0x1 << CC2430_WDCTL_MODE
};
//# 7 "/opt/emdoor/tos/chips/cc2430/Timer.h"
typedef uint8_t TMilli;
typedef uint8_t T32khz;
typedef uint8_t TMicro;
//# 49 "/opt/emdoor/tos/interfaces/Boot.nc"
static  void BlinkM__Boot__booted(void);
//# 64 "/opt/emdoor/tos/interfaces/TaskBasic.nc"
static  void BlinkM__DemoLed__runTask(void);
//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
static  error_t LedsP__Init__init(void);
//# 11 "/opt/emdoor/tos/interfaces/Leds.nc"
static   void LedsP__Leds__RedLedOff(void);
//#line 57
static   void LedsP__Leds__GreenLedOn(void);
//#line 43
static   void LedsP__Leds__YellowLedOff(void);
//#line 62
static   void LedsP__Leds__GreenLedOff(void);
//#line 6
static   void LedsP__Leds__RedLedOn(void);
//#line 27
static   void LedsP__Leds__BlueLedOff(void);
//#line 22
static   void LedsP__Leds__BlueLedOn(void);
//#line 38
static   void LedsP__Leds__YellowLedOn(void);
//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
static   void HplCC2430GeneralIOC__P01__makeOutput(void);
//#line 29
static   void HplCC2430GeneralIOC__P01__set(void);
static   void HplCC2430GeneralIOC__P01__clr(void);




static   void HplCC2430GeneralIOC__P13__makeOutput(void);
//#line 29
static   void HplCC2430GeneralIOC__P13__set(void);
static   void HplCC2430GeneralIOC__P13__clr(void);




static   void HplCC2430GeneralIOC__P11__makeOutput(void);
//#line 29
static   void HplCC2430GeneralIOC__P11__set(void);
static   void HplCC2430GeneralIOC__P11__clr(void);




static   void HplCC2430GeneralIOC__P14__makeOutput(void);
//#line 29
static   void HplCC2430GeneralIOC__P14__set(void);
static   void HplCC2430GeneralIOC__P14__clr(void);




static   void HplCC2430GeneralIOC__P12__makeOutput(void);
//#line 29
static   void HplCC2430GeneralIOC__P12__set(void);
static   void HplCC2430GeneralIOC__P12__clr(void);




static   void HplCC2430GeneralIOC__P10__makeOutput(void);
//#line 29
static   void HplCC2430GeneralIOC__P10__set(void);
static   void HplCC2430GeneralIOC__P10__clr(void);




static   void HplCC2430GeneralIOC__P20__makeOutput(void);
//#line 29
static   void HplCC2430GeneralIOC__P20__set(void);
static   void HplCC2430GeneralIOC__P20__clr(void);
//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
static  error_t PlatformP__Init__init(void);
//# 58 "/opt/emdoor/tos/interfaces/ActiveMessageAddress.nc"
static   void FlashIEEEP__ActiveMessageAddress__changed(void);
//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
static  error_t FlashIEEEP__Init__init(void);
//# 5 "/opt/emdoor/tos/platforms/zigbem/FlashIEEE.nc"
static  uint16_t FlashIEEEP__FlashIEEE__GetShortAddress(void);


static  void FlashIEEEP__FlashIEEE__WriteToAM(void);
//#line 4
static  uint16_t FlashIEEEP__FlashIEEE__GetPANID(void);


static  void FlashIEEEP__FlashIEEE__WriteToRegister(void);
//# 43 "/opt/emdoor/tos/interfaces/ActiveMessageAddress.nc"
static   void ActiveMessageAddressC__ActiveMessageAddress__setAddress(am_group_t arg_0x7e9c3f10, am_addr_t arg_0x7e9b60b0);
//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
static  error_t RealMainP__SoftwareInit__default__init(void);
//# 56 "/opt/emdoor/tos/interfaces/TaskBasic.nc"
static   error_t SchedulerBasicP__TaskBasic__postTask(
//# 45 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
uint8_t arg_0x7ed54e00);
//# 64 "/opt/emdoor/tos/interfaces/TaskBasic.nc"
static  void SchedulerBasicP__TaskBasic__default__runTask(
//# 45 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
uint8_t arg_0x7ed54e00);
//# 46 "/opt/emdoor/tos/interfaces/Scheduler.nc"
static  void SchedulerBasicP__Scheduler__init(void);
//#line 61
static  void SchedulerBasicP__Scheduler__taskLoop(void);
//#line 54
static  bool SchedulerBasicP__Scheduler__runNextTask(void);
//# 59 "/opt/emdoor/tos/interfaces/McuSleep.nc"
static   void McuSleepP__McuSleep__sleep(void);
//# 7 "/opt/emdoor/tos/lib/zigbem/power/McuSleepControl.nc"
static  void McuSleepP__McuSleepControl__default__beforeSleep(void);

static  void McuSleepP__McuSleepControl__default__afterWakeup(void);
//# 3 "/opt/emdoor/tos/lib/zigbem/power/McuSleepLockMan.nc"
static  bool /*McuSleepLockManC.McuSleepLockManP*/McuSleepLockManP__0__McuSleepLockMan__isLocked(void);
//# 11 "/opt/emdoor/tos/interfaces/Leds.nc"
static   void BlinkM__Leds__RedLedOff(void);
//#line 57
static   void BlinkM__Leds__GreenLedOn(void);
//#line 43
static   void BlinkM__Leds__YellowLedOff(void);
//#line 62
static   void BlinkM__Leds__GreenLedOff(void);
//#line 6
static   void BlinkM__Leds__RedLedOn(void);
//#line 27
static   void BlinkM__Leds__BlueLedOff(void);
//#line 22
static   void BlinkM__Leds__BlueLedOn(void);
//#line 38
static   void BlinkM__Leds__YellowLedOn(void);
//# 56 "/opt/emdoor/tos/interfaces/TaskBasic.nc"
static   error_t BlinkM__DemoLed__postTask(void);
//# 13 "BlinkM.nc"
enum BlinkM____nesc_unnamed4273 {
//#line 13
  BlinkM__DemoLed = 0U
};
//#line 13
typedef int BlinkM____nesc_sillytask_DemoLed[];
//#line 13
static  void BlinkM__DemoLed__runTask(void);
//#line 38
static  /*inline*/   void BlinkM__Boot__booted(void);
//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
static   void LedsP__BoardYellowLed__makeOutput(void);
//#line 29
static   void LedsP__BoardYellowLed__set(void);
static   void LedsP__BoardYellowLed__clr(void);




static   void LedsP__BlueLed__makeOutput(void);
//#line 29
static   void LedsP__BlueLed__set(void);
static   void LedsP__BlueLed__clr(void);




static   void LedsP__RedLed__makeOutput(void);
//#line 29
static   void LedsP__RedLed__set(void);
static   void LedsP__RedLed__clr(void);




static   void LedsP__BoardBlueLed__makeOutput(void);
//#line 29
static   void LedsP__BoardBlueLed__set(void);
static   void LedsP__BoardBlueLed__clr(void);




static   void LedsP__YellowLed__makeOutput(void);
//#line 29
static   void LedsP__YellowLed__set(void);
static   void LedsP__YellowLed__clr(void);




static   void LedsP__BoardGreenLed__makeOutput(void);
//#line 29
static   void LedsP__BoardGreenLed__set(void);
static   void LedsP__BoardGreenLed__clr(void);




static   void LedsP__BoardRedLed__makeOutput(void);
//#line 29
static   void LedsP__BoardRedLed__set(void);
static   void LedsP__BoardRedLed__clr(void);
//# 27 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/   error_t LedsP__Init__init(void);
//#line 49
static  /*inline*/    void LedsP__Leds__RedLedOn(void);






static  /*inline*/    void LedsP__Leds__RedLedOff(void);
//#line 70
static  /*inline*/    void LedsP__Leds__BlueLedOn(void);






static  /*inline*/    void LedsP__Leds__BlueLedOff(void);
//#line 91
static  /*inline*/    void LedsP__Leds__YellowLedOn(void);






static  /*inline*/    void LedsP__Leds__YellowLedOff(void);
//#line 114
static  /*inline*/    void LedsP__Leds__GreenLedOn(void);



static  /*inline*/    void LedsP__Leds__GreenLedOff(void);
//# 94 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P01__set(void);
//#line 94
static   /*inline*/     void HplCC2430GeneralIOC__P01__clr(void);
//#line 94
static   /*inline*/     void HplCC2430GeneralIOC__P01__makeOutput(void);







static   /*inline*/     void HplCC2430GeneralIOC__P10__set(void);
//#line 102
static   /*inline*/     void HplCC2430GeneralIOC__P10__clr(void);
//#line 102
static   /*inline*/     void HplCC2430GeneralIOC__P10__makeOutput(void);
static   /*inline*/     void HplCC2430GeneralIOC__P11__set(void);
//#line 103
static   /*inline*/     void HplCC2430GeneralIOC__P11__clr(void);
//#line 103
static   /*inline*/     void HplCC2430GeneralIOC__P11__makeOutput(void);
static   /*inline*/     void HplCC2430GeneralIOC__P12__set(void);
//#line 104
static   /*inline*/     void HplCC2430GeneralIOC__P12__clr(void);
//#line 104
static   /*inline*/     void HplCC2430GeneralIOC__P12__makeOutput(void);
static   /*inline*/     void HplCC2430GeneralIOC__P13__set(void);
//#line 105
static   /*inline*/     void HplCC2430GeneralIOC__P13__clr(void);
//#line 105
static   /*inline*/     void HplCC2430GeneralIOC__P13__makeOutput(void);
static   /*inline*/     void HplCC2430GeneralIOC__P14__set(void);
//#line 106
static   /*inline*/     void HplCC2430GeneralIOC__P14__clr(void);
//#line 106
static   /*inline*/     void HplCC2430GeneralIOC__P14__makeOutput(void);




static   /*inline*/     void HplCC2430GeneralIOC__P20__set(void);
//#line 111
static   /*inline*/     void HplCC2430GeneralIOC__P20__clr(void);
//#line 111
static   /*inline*/     void HplCC2430GeneralIOC__P20__makeOutput(void);
//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
static  error_t PlatformP__FlashIEEEInit__init(void);
//#line 51
static  error_t PlatformP__LedsInit__init(void);
//# 8 "/opt/emdoor/tos/platforms/zigbem/FlashIEEE.nc"
static  void PlatformP__FlashIEEE__WriteToAM(void);
//#line 7
static  void PlatformP__FlashIEEE__WriteToRegister(void);
//# 19 "/opt/emdoor/tos/platforms/zigbem/PlatformP.nc"
static  /*inline*/   error_t PlatformP__Init__init(void);
//# 43 "/opt/emdoor/tos/interfaces/ActiveMessageAddress.nc"
static   void FlashIEEEP__ActiveMessageAddress__setAddress(am_group_t arg_0x7e9c3f10, am_addr_t arg_0x7e9b60b0);
//# 17 "/opt/emdoor/tos/platforms/zigbem/FlashIEEEP.nc"
uint8_t FlashIEEEP__m_ieee[8];

static  /*inline*/   error_t FlashIEEEP__Init__init(void);
//#line 53
static  uint16_t FlashIEEEP__FlashIEEE__GetPANID(void);





static  uint16_t FlashIEEEP__FlashIEEE__GetShortAddress(void);










static  /*inline*/   void FlashIEEEP__FlashIEEE__WriteToRegister(void);
//#line 89
static  /*inline*/   void FlashIEEEP__FlashIEEE__WriteToAM(void);










static  /*inline*/    void FlashIEEEP__ActiveMessageAddress__changed(void);
//# 58 "/opt/emdoor/tos/interfaces/ActiveMessageAddress.nc"
static   void ActiveMessageAddressC__ActiveMessageAddress__changed(void);
//# 51 "/opt/emdoor/tos/system/ActiveMessageAddressC.nc"
am_addr_t ActiveMessageAddressC__addr = TOS_AM_ADDRESS;


am_group_t ActiveMessageAddressC__group = TOS_AM_GROUP;
//#line 70
static  /*inline*/    void ActiveMessageAddressC__ActiveMessageAddress__setAddress(am_group_t myGroup, am_addr_t myAddr);
//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
static  error_t RealMainP__SoftwareInit__init(void);
//# 49 "/opt/emdoor/tos/interfaces/Boot.nc"
static  void RealMainP__Boot__booted(void);
//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
static  error_t RealMainP__PlatformInit__init(void);
//# 46 "/opt/emdoor/tos/interfaces/Scheduler.nc"
static  void RealMainP__Scheduler__init(void);
//#line 61
static  void RealMainP__Scheduler__taskLoop(void);
//#line 54
static  bool RealMainP__Scheduler__runNextTask(void);
//# 52 "/opt/emdoor/tos/system/RealMainP.nc"
int main(void)   ;
//#line 94
static  /*inline*/    error_t RealMainP__SoftwareInit__default__init(void);
//# 64 "/opt/emdoor/tos/interfaces/TaskBasic.nc"
static  void SchedulerBasicP__TaskBasic__runTask(
//# 45 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
uint8_t arg_0x7ed54e00);
//# 59 "/opt/emdoor/tos/interfaces/McuSleep.nc"
static   void SchedulerBasicP__McuSleep__sleep(void);
//# 50 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
enum SchedulerBasicP____nesc_unnamed4274 {

  SchedulerBasicP__NUM_TASKS = 1U, 
  SchedulerBasicP__NO_TASK = 255
};

volatile uint8_t SchedulerBasicP__m_head;
volatile uint8_t SchedulerBasicP__m_tail;
volatile uint8_t SchedulerBasicP__m_next[SchedulerBasicP__NUM_TASKS];








static   /*inline*/   uint8_t SchedulerBasicP__popTask(void);
//#line 86
static  /*inline*/  bool SchedulerBasicP__isWaiting(uint8_t id);




static  /*inline*/  bool SchedulerBasicP__pushTask(uint8_t id);
//#line 113
static  /*inline*/   void SchedulerBasicP__Scheduler__init(void);









static  bool SchedulerBasicP__Scheduler__runNextTask(void);
//#line 139
static  /*inline*/   void SchedulerBasicP__Scheduler__taskLoop(void);
//#line 174
static  /*inline*/    error_t SchedulerBasicP__TaskBasic__postTask(uint8_t id);




static  /*inline*/    void SchedulerBasicP__TaskBasic__default__runTask(uint8_t id);
//# 3 "/opt/emdoor/tos/lib/zigbem/power/McuSleepLockMan.nc"
static  bool McuSleepP__McuSleepLockMan__isLocked(void);
//# 7 "/opt/emdoor/tos/lib/zigbem/power/McuSleepControl.nc"
static  void McuSleepP__McuSleepControl__beforeSleep(void);

static  void McuSleepP__McuSleepControl__afterWakeup(void);
//# 13 "/opt/emdoor/tos/lib/zigbem/power/McuSleepP.nc"
bool McuSleepP__m_need_sleep = FALSE;
//#line 27
static  /*inline*/    void McuSleepP__McuSleep__sleep(void);
//#line 54
static  /*inline*/    void McuSleepP__McuSleepControl__default__beforeSleep(void);


static  /*inline*/    void McuSleepP__McuSleepControl__default__afterWakeup(void);
//# 9 "/opt/emdoor/tos/lib/zigbem/power/McuSleepLockManP.nc"
 uint32_t /*McuSleepLockManC.McuSleepLockManP*/McuSleepLockManP__0__lock_bitmap = 0x00000000;
//#line 37
static  /*inline*/   bool /*McuSleepLockManC.McuSleepLockManP*/McuSleepLockManP__0__McuSleepLockMan__isLocked(void);
//# 67 "/opt/emdoor/tos/chips/cc2430/mcs51/mcs51hardware.h"
   /*inline*/   __nesc_atomic_t __nesc_atomic_start(void )
//#line 67
{
  __nesc_atomic_t tmp = EA;

//#line 69
  EA = 0;
  return tmp;
}

   /*inline*/   void __nesc_atomic_end(__nesc_atomic_t oldSreg)
//#line 73
{
  EA = oldSreg;
}

//# 113 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
static  /*inline*/   void SchedulerBasicP__Scheduler__init(void)
{
  /* atomic removed: atomic calls only */
  {
    memset((void *)SchedulerBasicP__m_next, SchedulerBasicP__NO_TASK, sizeof SchedulerBasicP__m_next);
    SchedulerBasicP__m_head = SchedulerBasicP__NO_TASK;
    SchedulerBasicP__m_tail = SchedulerBasicP__NO_TASK;
  }
}

//# 46 "/opt/emdoor/tos/interfaces/Scheduler.nc"
#define RealMainP__Scheduler__init(void) SchedulerBasicP__Scheduler__init()
//# 100 "/opt/emdoor/tos/platforms/zigbem/FlashIEEEP.nc"
static  /*inline*/    void FlashIEEEP__ActiveMessageAddress__changed(void)
{
}

//# 58 "/opt/emdoor/tos/interfaces/ActiveMessageAddress.nc"
#define ActiveMessageAddressC__ActiveMessageAddress__changed(void) FlashIEEEP__ActiveMessageAddress__changed()
//# 70 "/opt/emdoor/tos/system/ActiveMessageAddressC.nc"
static  /*inline*/    void ActiveMessageAddressC__ActiveMessageAddress__setAddress(am_group_t myGroup, am_addr_t myAddr)
//#line 70
{
  /* atomic removed: atomic calls only */
//#line 71
  {
    ActiveMessageAddressC__addr = myAddr;
    ActiveMessageAddressC__group = myGroup;
  }
  ActiveMessageAddressC__ActiveMessageAddress__changed();
}

//# 43 "/opt/emdoor/tos/interfaces/ActiveMessageAddress.nc"
#define FlashIEEEP__ActiveMessageAddress__setAddress(arg_0x7e9c3f10,arg_0x7e9b60b0) ActiveMessageAddressC__ActiveMessageAddress__setAddress(arg_0x7e9c3f10, arg_0x7e9b60b0)
//# 89 "/opt/emdoor/tos/platforms/zigbem/FlashIEEEP.nc"
static  /*inline*/   void FlashIEEEP__FlashIEEE__WriteToAM(void)
{
  FlashIEEEP__ActiveMessageAddress__setAddress((uint8_t )(FlashIEEEP__FlashIEEE__GetPANID() & 0xFF), 
  FlashIEEEP__FlashIEEE__GetShortAddress());

  TOS_NODE_ID = FlashIEEEP__FlashIEEE__GetShortAddress();

  TOS_IEEE_SADDR = FlashIEEEP__FlashIEEE__GetShortAddress();
  TOS_IEEE_PANID = FlashIEEEP__FlashIEEE__GetPANID();
}

//# 8 "/opt/emdoor/tos/platforms/zigbem/FlashIEEE.nc"
#define PlatformP__FlashIEEE__WriteToAM(void) FlashIEEEP__FlashIEEE__WriteToAM()
//# 70 "/opt/emdoor/tos/platforms/zigbem/FlashIEEEP.nc"
static  /*inline*/   void FlashIEEEP__FlashIEEE__WriteToRegister(void)
{
  ;


  * (uint8_t xdata *)0xDF43 = FlashIEEEP__m_ieee[0];
  * (uint8_t xdata *)0xDF44 = FlashIEEEP__m_ieee[1];
  * (uint8_t xdata *)0xDF45 = FlashIEEEP__m_ieee[2];
  * (uint8_t xdata *)0xDF46 = FlashIEEEP__m_ieee[3];
  * (uint8_t xdata *)0xDF47 = FlashIEEEP__m_ieee[4];
  * (uint8_t xdata *)0xDF48 = FlashIEEEP__m_ieee[5];
  * (uint8_t xdata *)0xDF49 = FlashIEEEP__m_ieee[6];
  * (uint8_t xdata *)0xDF4A = FlashIEEEP__m_ieee[7];


  * (uint16_t xdata *)0xDF4B = FlashIEEEP__FlashIEEE__GetPANID();
  * (uint16_t xdata *)0xDF4D = FlashIEEEP__FlashIEEE__GetShortAddress();
}

//# 7 "/opt/emdoor/tos/platforms/zigbem/FlashIEEE.nc"
#define PlatformP__FlashIEEE__WriteToRegister(void) FlashIEEEP__FlashIEEE__WriteToRegister()
//# 19 "/opt/emdoor/tos/platforms/zigbem/FlashIEEEP.nc"
static  /*inline*/   error_t FlashIEEEP__Init__init(void)
{
  uint8_t i;
  uint16_t old_code_map;

  /* atomic removed: atomic calls only */
//#line 24
  {
    ;

    {
//#line 27
      old_code_map = MEMCTR;
    }
//#line 27
    ;
    {
//#line 28
      MEMCTR = (MEMCTR & 0xCF) | (3 << 4);
    }
//#line 28
    ;

    FlashIEEEP__m_ieee[0] = * (uint8_t code *)(0xFFF8 + 7);
    FlashIEEEP__m_ieee[1] = * (uint8_t code *)(0xFFF8 + 6);
    FlashIEEEP__m_ieee[2] = * (uint8_t code *)(0xFFF8 + 5);
    FlashIEEEP__m_ieee[3] = * (uint8_t code *)(0xFFF8 + 4);
    FlashIEEEP__m_ieee[4] = * (uint8_t code *)(0xFFF8 + 3);
    FlashIEEEP__m_ieee[5] = * (uint8_t code *)(0xFFF8 + 2);
    FlashIEEEP__m_ieee[6] = * (uint8_t code *)(0xFFF8 + 1);
    FlashIEEEP__m_ieee[7] = * (uint8_t code *)(0xFFF8 + 0);

    for (i = 0; i < 8; ++i) 
      {
        ;
      }


    ;

    {
//#line 47
      MEMCTR = old_code_map;
    }
//#line 47
    ;
  }

  return SUCCESS;
}

//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
#define PlatformP__FlashIEEEInit__init(void) FlashIEEEP__Init__init()
//# 106 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P14__set(void)
//#line 106
{
//#line 106
  P1_4 = 1;
}

//# 29 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardYellowLed__set(void) HplCC2430GeneralIOC__P14__set()
//# 102 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P10__set(void)
//#line 102
{
//#line 102
  P1_0 = 1;
}

//# 29 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardGreenLed__set(void) HplCC2430GeneralIOC__P10__set()
//# 103 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P11__set(void)
//#line 103
{
//#line 103
  P1_1 = 1;
}

//# 29 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardBlueLed__set(void) HplCC2430GeneralIOC__P11__set()
//# 94 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P01__set(void)
//#line 94
{
//#line 94
  P0_1 = 1;
}

//# 29 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardRedLed__set(void) HplCC2430GeneralIOC__P01__set()
//# 106 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P14__makeOutput(void)
//#line 106
{
//#line 106
  P1_DIR |= 1 << 4;
}

//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardYellowLed__makeOutput(void) HplCC2430GeneralIOC__P14__makeOutput()
//# 102 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P10__makeOutput(void)
//#line 102
{
//#line 102
  P1_DIR |= 1 << 0;
}

//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardGreenLed__makeOutput(void) HplCC2430GeneralIOC__P10__makeOutput()
//# 103 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P11__makeOutput(void)
//#line 103
{
//#line 103
  P1_DIR |= 1 << 1;
}

//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardBlueLed__makeOutput(void) HplCC2430GeneralIOC__P11__makeOutput()
//# 94 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P01__makeOutput(void)
//#line 94
{
//#line 94
  P0_DIR |= 1 << 1;
}

//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardRedLed__makeOutput(void) HplCC2430GeneralIOC__P01__makeOutput()
//# 111 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P20__set(void)
//#line 111
{
//#line 111
  P2_0 = 1;
}

//# 29 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__YellowLed__set(void) HplCC2430GeneralIOC__P20__set()
//# 104 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P12__set(void)
//#line 104
{
//#line 104
  P1_2 = 1;
}

//# 29 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BlueLed__set(void) HplCC2430GeneralIOC__P12__set()
//# 105 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P13__set(void)
//#line 105
{
//#line 105
  P1_3 = 1;
}

//# 29 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__RedLed__set(void) HplCC2430GeneralIOC__P13__set()
//# 111 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P20__makeOutput(void)
//#line 111
{
//#line 111
  P2_DIR |= 1 << 0;
}

//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__YellowLed__makeOutput(void) HplCC2430GeneralIOC__P20__makeOutput()
//# 104 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P12__makeOutput(void)
//#line 104
{
//#line 104
  P1_DIR |= 1 << 2;
}

//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BlueLed__makeOutput(void) HplCC2430GeneralIOC__P12__makeOutput()
//# 105 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P13__makeOutput(void)
//#line 105
{
//#line 105
  P1_DIR |= 1 << 3;
}

//# 35 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__RedLed__makeOutput(void) HplCC2430GeneralIOC__P13__makeOutput()
//# 27 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/   error_t LedsP__Init__init(void)
//#line 27
{
  /* atomic removed: atomic calls only */
//#line 28
  {
    LedsP__RedLed__makeOutput();
    LedsP__BlueLed__makeOutput();
    LedsP__YellowLed__makeOutput();
    LedsP__RedLed__set();
    LedsP__BlueLed__set();
    LedsP__YellowLed__set();

    LedsP__BoardRedLed__makeOutput();
    LedsP__BoardBlueLed__makeOutput();
    LedsP__BoardGreenLed__makeOutput();
    LedsP__BoardYellowLed__makeOutput();
    LedsP__BoardRedLed__set();
    LedsP__BoardBlueLed__set();
    LedsP__BoardGreenLed__set();
    LedsP__BoardYellowLed__set();
  }

  return SUCCESS;
}

//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
#define PlatformP__LedsInit__init(void) LedsP__Init__init()
//# 19 "/opt/emdoor/tos/platforms/zigbem/PlatformP.nc"
static  /*inline*/   error_t PlatformP__Init__init(void)
//#line 19
{
  uint8_t new_clkcon;

  SLEEP = (SLEEP & ~CC2430_SLEEP_MODE_MASK) | CC2430_SLEEP_POWERMODE_0;



  SLEEP &= ~(1 << CC2430_SLEEP_OSC_PD);
  while (!(SLEEP & (1 << CC2430_SLEEP_XOSC_STB))) ;

  new_clkcon = 0x0;



  new_clkcon = (new_clkcon & ~CC2430_CLKCON_TICKSPD_MASK) | CC2430_TICKF_DIV_8;


  new_clkcon &= ~(1 << CC2430_CLKCON_OSC32K);






  new_clkcon &= ~(1 << CC2430_CLKCON_OSC);



  CLKCON = new_clkcon;







  PlatformP__LedsInit__init();





  PlatformP__FlashIEEEInit__init();
  PlatformP__FlashIEEE__WriteToRegister();
  PlatformP__FlashIEEE__WriteToAM();



  return SUCCESS;
}

//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
#define RealMainP__PlatformInit__init(void) PlatformP__Init__init()
//# 54 "/opt/emdoor/tos/interfaces/Scheduler.nc"
#define RealMainP__Scheduler__runNextTask(void) SchedulerBasicP__Scheduler__runNextTask()
//# 91 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__YellowLedOn(void)
//#line 91
{
  LedsP__YellowLed__set();

  LedsP__BoardYellowLed__set();
}

//# 38 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__YellowLedOn(void) LedsP__Leds__YellowLedOn()
//# 94 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P01__clr(void)
//#line 94
{
//#line 94
  P0_1 = 0;
}

//# 30 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardRedLed__clr(void) HplCC2430GeneralIOC__P01__clr()
//# 105 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P13__clr(void)
//#line 105
{
//#line 105
  P1_3 = 0;
}

//# 30 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__RedLed__clr(void) HplCC2430GeneralIOC__P13__clr()
//# 56 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__RedLedOff(void)
//#line 56
{
  LedsP__RedLed__clr();

  LedsP__BoardRedLed__clr();
}

//# 11 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__RedLedOff(void) LedsP__Leds__RedLedOff()
//# 70 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__BlueLedOn(void)
//#line 70
{
  LedsP__BlueLed__set();

  LedsP__BoardBlueLed__set();
}

//# 22 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__BlueLedOn(void) LedsP__Leds__BlueLedOn()
//# 102 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P10__clr(void)
//#line 102
{
//#line 102
  P1_0 = 0;
}

//# 30 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardGreenLed__clr(void) HplCC2430GeneralIOC__P10__clr()
//# 118 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__GreenLedOff(void)
//#line 118
{
  LedsP__BoardGreenLed__clr();
}

//# 62 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__GreenLedOff(void) LedsP__Leds__GreenLedOff()
//# 106 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P14__clr(void)
//#line 106
{
//#line 106
  P1_4 = 0;
}

//# 30 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardYellowLed__clr(void) HplCC2430GeneralIOC__P14__clr()
//# 111 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P20__clr(void)
//#line 111
{
//#line 111
  P2_0 = 0;
}

//# 30 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__YellowLed__clr(void) HplCC2430GeneralIOC__P20__clr()
//# 98 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__YellowLedOff(void)
//#line 98
{
  LedsP__YellowLed__clr();

  LedsP__BoardYellowLed__clr();
}

//# 43 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__YellowLedOff(void) LedsP__Leds__YellowLedOff()
//# 49 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__RedLedOn(void)
//#line 49
{
  LedsP__RedLed__set();

  LedsP__BoardRedLed__set();
}

//# 6 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__RedLedOn(void) LedsP__Leds__RedLedOn()
//# 103 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P11__clr(void)
//#line 103
{
//#line 103
  P1_1 = 0;
}

//# 30 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BoardBlueLed__clr(void) HplCC2430GeneralIOC__P11__clr()
//# 104 "/opt/emdoor/tos/chips/cc2430/pins/HplCC2430GeneralIOC.nc"
static   /*inline*/     void HplCC2430GeneralIOC__P12__clr(void)
//#line 104
{
//#line 104
  P1_2 = 0;
}

//# 30 "/opt/emdoor/tos/interfaces/GeneralIO.nc"
#define LedsP__BlueLed__clr(void) HplCC2430GeneralIOC__P12__clr()
//# 77 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__BlueLedOff(void)
//#line 77
{
  LedsP__BlueLed__clr();

  LedsP__BoardBlueLed__clr();
}

//# 27 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__BlueLedOff(void) LedsP__Leds__BlueLedOff()
//# 114 "/opt/emdoor/tos/system/LedsP.nc"
static  /*inline*/    void LedsP__Leds__GreenLedOn(void)
//#line 114
{
  LedsP__BoardGreenLed__set();
}

//# 57 "/opt/emdoor/tos/interfaces/Leds.nc"
#define BlinkM__Leds__GreenLedOn(void) LedsP__Leds__GreenLedOn()
//# 94 "/opt/emdoor/tos/system/RealMainP.nc"
static  /*inline*/    error_t RealMainP__SoftwareInit__default__init(void)
//#line 94
{
//#line 94
  return SUCCESS;
}

//# 51 "/opt/emdoor/tos/interfaces/Init.nc"
#define RealMainP__SoftwareInit__init(void) RealMainP__SoftwareInit__default__init()
//# 86 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
static  /*inline*/  bool SchedulerBasicP__isWaiting(uint8_t id)
{
  return SchedulerBasicP__m_next[id] != SchedulerBasicP__NO_TASK || SchedulerBasicP__m_tail == id;
}

static  /*inline*/  bool SchedulerBasicP__pushTask(uint8_t id)
{
  if (!SchedulerBasicP__isWaiting(id)) 
    {
      if (SchedulerBasicP__m_head == SchedulerBasicP__NO_TASK) 
        {
          SchedulerBasicP__m_head = id;
          SchedulerBasicP__m_tail = id;
        }
      else 
        {
          SchedulerBasicP__m_next[SchedulerBasicP__m_tail] = id;
          SchedulerBasicP__m_tail = id;
        }
      return TRUE;
    }
  else 
    {
      return FALSE;
    }
}

//#line 174
static  /*inline*/    error_t SchedulerBasicP__TaskBasic__postTask(uint8_t id)
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
//#line 176
    {
//#line 176
      {
        unsigned char __nesc_temp = 
//#line 176
        SchedulerBasicP__pushTask(id) ? SUCCESS : EBUSY;

        {
//#line 176
          __nesc_atomic_end(__nesc_atomic); 
//#line 176
          return __nesc_temp;
        }
      }
    }
//#line 179
    __nesc_atomic_end(__nesc_atomic); }
}

//# 56 "/opt/emdoor/tos/interfaces/TaskBasic.nc"
#define BlinkM__DemoLed__postTask(void) SchedulerBasicP__TaskBasic__postTask(BlinkM__DemoLed)
//# 38 "BlinkM.nc"
static  /*inline*/   void BlinkM__Boot__booted(void)
//#line 38
{
  BlinkM__DemoLed__postTask();
}

//# 49 "/opt/emdoor/tos/interfaces/Boot.nc"
#define RealMainP__Boot__booted(void) BlinkM__Boot__booted()
//# 57 "/opt/emdoor/tos/lib/zigbem/power/McuSleepP.nc"
static  /*inline*/    void McuSleepP__McuSleepControl__default__afterWakeup(void)
{
}

//# 9 "/opt/emdoor/tos/lib/zigbem/power/McuSleepControl.nc"
#define McuSleepP__McuSleepControl__afterWakeup(void) McuSleepP__McuSleepControl__default__afterWakeup()
//# 65 "/opt/emdoor/tos/chips/cc2430/mcs51/mcs51hardware.h"
static   /*inline*/   void __nesc_enable_interrupt(void)
//#line 65
{
//#line 65
  EA = 1;
}

//# 54 "/opt/emdoor/tos/lib/zigbem/power/McuSleepP.nc"
static  /*inline*/    void McuSleepP__McuSleepControl__default__beforeSleep(void)
{
}

//# 7 "/opt/emdoor/tos/lib/zigbem/power/McuSleepControl.nc"
#define McuSleepP__McuSleepControl__beforeSleep(void) McuSleepP__McuSleepControl__default__beforeSleep()
//# 37 "/opt/emdoor/tos/lib/zigbem/power/McuSleepLockManP.nc"
static  /*inline*/   bool /*McuSleepLockManC.McuSleepLockManP*/McuSleepLockManP__0__McuSleepLockMan__isLocked(void)
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
//#line 39
    {
      unsigned char __nesc_temp = 
//#line 39
      /*McuSleepLockManC.McuSleepLockManP*/McuSleepLockManP__0__lock_bitmap != 0x00000000;

      {
//#line 39
        __nesc_atomic_end(__nesc_atomic); 
//#line 39
        return __nesc_temp;
      }
    }
//#line 41
    __nesc_atomic_end(__nesc_atomic); }
}

//# 3 "/opt/emdoor/tos/lib/zigbem/power/McuSleepLockMan.nc"
#define McuSleepP__McuSleepLockMan__isLocked(void) McuSleepLockManP__0__McuSleepLockMan__isLocked()
//# 27 "/opt/emdoor/tos/lib/zigbem/power/McuSleepP.nc"
static  /*inline*/    void McuSleepP__McuSleep__sleep(void)
{


  if (McuSleepP__m_need_sleep && !McuSleepP__McuSleepLockMan__isLocked()) 
    {
      ;
      SLEEP = (SLEEP & ~CC2430_SLEEP_MODE_MASK) | CC2430_SLEEP_POWERMODE_2;

      McuSleepP__McuSleepControl__beforeSleep();

      __nesc_enable_interrupt();

      PCON = 0x01;
      ;

      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
//#line 43
        McuSleepP__m_need_sleep = FALSE;
//#line 43
        __nesc_atomic_end(__nesc_atomic); }

      McuSleepP__McuSleepControl__afterWakeup();
    }
  else 
    {
    }
}

//# 59 "/opt/emdoor/tos/interfaces/McuSleep.nc"
#define SchedulerBasicP__McuSleep__sleep(void) McuSleepP__McuSleep__sleep()
//# 179 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
static  /*inline*/    void SchedulerBasicP__TaskBasic__default__runTask(uint8_t id)
{
}

//# 64 "/opt/emdoor/tos/interfaces/TaskBasic.nc"
 /*inline*/  static  void SchedulerBasicP__TaskBasic__runTask(uint8_t arg_0x7ed54e00){
//#line 64
  switch (arg_0x7ed54e00) {
//#line 64
    case BlinkM__DemoLed:
//#line 64
      BlinkM__DemoLed__runTask();
//#line 64
      break;
//#line 64
    default:
//#line 64
      SchedulerBasicP__TaskBasic__default__runTask(arg_0x7ed54e00);
//#line 64
      break;
//#line 64
    }
//#line 64
}
//#line 64
//# 67 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
static   /*inline*/   uint8_t SchedulerBasicP__popTask(void)
{
  if (SchedulerBasicP__m_head != SchedulerBasicP__NO_TASK) 
    {
      uint8_t id = SchedulerBasicP__m_head;

//#line 72
      SchedulerBasicP__m_head = SchedulerBasicP__m_next[SchedulerBasicP__m_head];
      if (SchedulerBasicP__m_head == SchedulerBasicP__NO_TASK) 
        {
          SchedulerBasicP__m_tail = SchedulerBasicP__NO_TASK;
        }
      SchedulerBasicP__m_next[id] = SchedulerBasicP__NO_TASK;
      return id;
    }
  else 
    {
      return SchedulerBasicP__NO_TASK;
    }
}

//#line 139
static  /*inline*/   void SchedulerBasicP__Scheduler__taskLoop(void)
{
  for (; ; ) 
    {
      uint8_t nextTask;

      { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
        {
          nextTask = SchedulerBasicP__popTask();
        }
//#line 148
        __nesc_atomic_end(__nesc_atomic); }

      current_task_id = nextTask;

      if (nextTask != SchedulerBasicP__NO_TASK) 
        {
          SchedulerBasicP__TaskBasic__runTask(nextTask);
        }

      SchedulerBasicP__McuSleep__sleep();
    }
}

//# 61 "/opt/emdoor/tos/interfaces/Scheduler.nc"
#define RealMainP__Scheduler__taskLoop(void) SchedulerBasicP__Scheduler__taskLoop()
//# 64 "/opt/emdoor/tos/chips/cc2430/mcs51/mcs51hardware.h"
static   /*inline*/   void __nesc_disable_interrupt(void)
//#line 64
{
//#line 64
  EA = 0;
}

//# 52 "/opt/emdoor/tos/system/RealMainP.nc"
  int main(void)
//#line 52
{
  { __nesc_atomic_t __nesc_atomic = __nesc_atomic_start();
    {





      {
      }
//#line 60
      ;

      RealMainP__Scheduler__init();





      RealMainP__PlatformInit__init();
      while (RealMainP__Scheduler__runNextTask()) ;





      RealMainP__SoftwareInit__init();
      while (RealMainP__Scheduler__runNextTask()) ;
    }
//#line 77
    __nesc_atomic_end(__nesc_atomic); }


  __nesc_enable_interrupt();

  RealMainP__Boot__booted();


  RealMainP__Scheduler__taskLoop();




  return -1;
}

//# 53 "/opt/emdoor/tos/platforms/zigbem/FlashIEEEP.nc"
static  uint16_t FlashIEEEP__FlashIEEE__GetPANID(void)
{
  return (FlashIEEEP__m_ieee[4] << 8) | FlashIEEEP__m_ieee[5];
}


static  uint16_t FlashIEEEP__FlashIEEE__GetShortAddress(void)
{
  return (FlashIEEEP__m_ieee[6] << 8) | FlashIEEEP__m_ieee[7];
}

//# 123 "/opt/emdoor/tos/system/SchedulerBasicP.nc"
static  bool SchedulerBasicP__Scheduler__runNextTask(void)
{
  uint8_t nextTask;

  /* atomic removed: atomic calls only */
//#line 127
  {
    nextTask = SchedulerBasicP__popTask();

    if (nextTask == SchedulerBasicP__NO_TASK) 
      {
        {
          unsigned char __nesc_temp = 
//#line 132
          FALSE;

//#line 132
          return __nesc_temp;
        }
      }
  }
//#line 135
  SchedulerBasicP__TaskBasic__runTask(nextTask);
  return TRUE;
}

//# 13 "BlinkM.nc"
static  void BlinkM__DemoLed__runTask(void)
//#line 13
{
  int i;
//#line 14
  int j;

  while (1) {
      for (i = 0; i < 1000; i++) 
        for (j = 0; j < 500; j++) ;

      BlinkM__Leds__YellowLedOn();
      BlinkM__Leds__RedLedOff();
      BlinkM__Leds__BlueLedOn();
      BlinkM__Leds__GreenLedOff();

      for (i = 0; i < 1000; i++) 
        for (j = 0; j < 500; j++) ;

      BlinkM__Leds__YellowLedOff();
      BlinkM__Leds__RedLedOn();
      BlinkM__Leds__BlueLedOff();
      BlinkM__Leds__GreenLedOn();
    }
}

