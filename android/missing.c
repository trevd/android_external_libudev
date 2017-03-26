
#include <string.h>

void *mempcpy(void * __restrict s1, const void * __restrict s2, size_t n)
{
	register char *r1 = s1;
	register const char *r2 = s2;

	while (n) {
		*r1++ = *r2++;
		--n;
	}

	return r1;
}



#undef sysconf
long udev_sysconf(int name)
{
	switch(name) {
		case _SC_GETPW_R_SIZE_MAX: return 1024;
		default: return sysconf(name);
	}
}


char *canonicalize_file_name(const char *path)
{
	return realpath(path,NULL);
}
