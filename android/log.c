
#include <errno.h>
#include <stdarg.h>

#include <android/log.h>

#include "log.h"

static const char *tag = "udev";

void log_parse_environment(void)
{
}

int log_oom_internal(const char *file, int line, const char *func)
{
	__android_log_print(ANDROID_LOG_FATAL, tag, "%s (%s:%d): out of memory!", func, file, line);
	return -ENOMEM;
}

_noreturn_ void log_assert_failed(const char *text, const char *file, int line, const char *func)
{
	__android_log_print(ANDROID_LOG_FATAL, tag, "%s (%s:%d): assertion '%s' failed!", func, file, line, text);
	abort();
}

_noreturn_ void log_assert_failed_unreachable(const char *text, const char *file, int line, const char *func)
{
	__android_log_print(ANDROID_LOG_FATAL, tag, "%s (%s:%d): assertion '%s' failed!", func, file, line, text);
	abort();
}

int log_meta(int level, const char*file, int line, const char *func, const char *format, ...)
{
	va_list ap;

	va_start(ap, format);
	__android_log_vprint(ANDROID_LOG_DEBUG, tag, format, ap);
	va_end(ap);

	return 0;
}

int log_metav(int level, const char*file, int line, const char *func, const char *format, va_list ap)
{
	__android_log_vprint(ANDROID_LOG_DEBUG, tag, format, ap);
	return 0;
}

int log_open(void)
{
	return 0;
}

void log_close(void)
{
}

void log_set_target(LogTarget target)
{
}

void log_set_max_level(int level)
{
}

