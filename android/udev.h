/* fix-ups for building udev on Android */

#pragma once

#define _GNU_SOURCE

#define FIRMWARE_PATH  "/system/etc/firmware"
#define UDEVLIBEXECDIR "/system/etc/udev"

#include <grp.h>

/* stpcpy */
#include <string.h>
void *mempcpy(void *dest, const void *src, size_t n);

/* Return an alloca'd copy of at most N bytes of string.  */
# define strndupa(s,n)							\
  (__extension__							\
    ({									\
      const char *__old = (s);						\
      size_t __len = strnlen (__old, (n));				\
      char *__new = (char *) __builtin_alloca (__len + 1);		\
      __new[__len] = '\0';						\
      (char *) memcpy (__new, __old, __len);				\
    }))

/* Work-around redefinition of ALIGN */
#include <sys/param.h>
#ifdef ALIGN
#undef ALIGN
#endif

/* bionic has gettid */
#define HAVE_DECL_GETTID 1

/* bionic has pivot_root */
#define HAVE_DECL_PIVOT_ROOT 1

/* work-around for missing secure_getenv */
#define HAVE_SECURE_GETENV 1 /* claim we have it */
#define secure_getenv getenv /* but alias it to getenv() */

#include <limits.h>
#define LINE_MAX 2048


/* get cpu_set_t defined */
#include <sched.h>
#define SCHED_IDLE 5 /* not defined in bionic */

/* bionic defines CPU_ALLOC with a trailing semi-colon... */
#undef CPU_ALLOC
#define CPU_ALLOC(count)   __sched_cpualloc((count))

/* use gcc builtins for __bswap_XX */
#define __bswap_16(x) ((uint16_t)(__builtin_bswap32 (x << 16)))
#define __bswap_32(x) __builtin_bswap32(x)
#define __bswap_64(x) __builtin_bswap64(x)

#include <sys/endian.h>

#include <sys/stat.h>
/*
 * UGLY HACK: Cleaning up the udev.h bionic overrides has exposed a difference
 * in the expected struct stat definitions for udev
 *
 * bionic definition of struct stat has the following 6 fields:
 * unsigned long st_atime;
 * unsigned long st_atime_nsec;
 * unsigned long st_mtime;
 * unsigned long st_mtime_nsec;
 * unsigned long st_ctime;
 * unsigned long st_ctime_nsec;
 *
 * The expected struct stat definition in libudev has the following 3 fields:
 * struct timespec st_atim;
 * struct timespec st_mtim;
 * struct timespec st_ctim;
 *
 */
#define st_atim st_atime
#define st_mtim st_mtime
#define st_ctim st_ctime

/* bionic does not define those */
#define	LOG_NFACILITIES	24
#define	IPTOS_LOWCOST   0x02

/* workaround for canonicalize_file_name */
extern char *canonicalize_file_name(const char *path);

#define program_invocation_name "udev"

#define nl_langinfo(x) "UTF-8"

/* for open_memstream() */
#include <cutils/open_memstream.h>

/* missing syscalls */
#include <sys/syscall.h>

/* work-around for missing mkostemp() */
#define mkostemp(t,f) mkstemp(t)

/* work-around for missing get_current_dir_name() */
#define get_current_dir_name() getcwd(0,0)

/* for stuff imported from uClibc such as glob.[ch] */
#define __USE_GNU 1
#define __UCLIBC_HAS_GNU_GLOB__ 1
#define __THROW   __attribute__ ((__nothrow__))
#define libc_hidden_proto(x)
#define attribute_hidden __attribute__ ((visibility ("hidden")))
#define libc_hidden_def(name)
#define true 1

/* Nonzero if STATUS indicates the child continued after a stop. */
#define W_CONTINUED      8       /* Report continued child.  */
#define WIFCONTINUED(status) ((status) == W_CONTINUED)

typedef int (*__compar_fn_t) (__const void *, __const void *);
typedef int (*__compar_d_fn_t) (const void *, const void *, void *);

/* no systemd, no need to sd_notify() */
#include "sd-daemon.h"
#define sd_notify(a,b) do {} while(0)
#define sd_listen_fds(x) -1
#define sd_is_socket(a,b,c,d) 0

#include "cgroup-util.h"
#define cg_pid_get_path(a,b,c) -1
#define cg_kill(a,b,c,d,e,f) do {} while(0)

/* missing qsort_r */
void qsort_r(void *base, size_t nmemb, size_t size,
		int (*compar)(const void *, const void *, void *),
		void *arg);

/* work-around issue of sysconf(_SC_GETPW_R_SIZE_MAX) returning -1 */
#include <sys/sysconf.h>
extern long udev_sysconf(int name);
#define sysconf(x) udev_sysconf(x)

