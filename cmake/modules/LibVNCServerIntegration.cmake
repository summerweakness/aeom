include(CheckFunctionExists)
include(CheckSymbolExists)
include(CheckIncludeFile)
include(CheckTypeSize)
include(TestBigEndian)
include(CheckCSourceCompiles)
include(CheckCSourceRuns)

check_include_file("endian.h"      LIBVNCSERVER_HAVE_ENDIAN_H)
check_include_file("fcntl.h"       LIBVNCSERVER_HAVE_FCNTL_H)
check_include_file("netinet/in.h"  LIBVNCSERVER_HAVE_NETINET_IN_H)
check_include_file("poll.h"        LIBVNCSERVER_HAVE_POLL_H)
check_include_file("sys/endian.h"  LIBVNCSERVER_HAVE_SYS_ENDIAN_H)
check_include_file("sys/socket.h"  LIBVNCSERVER_HAVE_SYS_SOCKET_H)
check_include_file("sys/stat.h"    LIBVNCSERVER_HAVE_SYS_STAT_H)
check_include_file("sys/time.h"    LIBVNCSERVER_HAVE_SYS_TIME_H)
check_include_file("sys/types.h"   LIBVNCSERVER_HAVE_SYS_TYPES_H)
check_include_file("sys/wait.h"    LIBVNCSERVER_HAVE_SYS_WAIT_H)
check_include_file("unistd.h"      LIBVNCSERVER_HAVE_UNISTD_H)
check_include_file("sys/uio.h"     LIBVNCSERVER_HAVE_SYS_UIO_H)
check_include_file("sys/resource.h"     LIBVNCSERVER_HAVE_SYS_RESOURCE_H)


# headers needed for check_type_size()
check_include_file("vfork.h"       LIBVNCSERVER_HAVE_VFORK_H)
check_include_file("ws2tcpip.h"    LIBVNCSERVER_HAVE_WS2TCPIP_H)
check_include_file("arpa/inet.h"   HAVE_ARPA_INET_H)
check_include_file("stdint.h"      HAVE_STDINT_H)
check_include_file("stddef.h"      HAVE_STDDEF_H)
check_include_file("sys/types.h"   HAVE_SYS_TYPES_H)

# error out if required headers not found
if(NOT HAVE_STDINT_H)
	message(FATAL_ERROR "Could NOT find required header stdint.h")
endif()

check_function_exists(gettimeofday    LIBVNCSERVER_HAVE_GETTIMEOFDAY)
check_function_exists(vfork           LIBVNCSERVER_HAVE_VFORK)
check_function_exists(vprintf         LIBVNCSERVER_HAVE_VPRINTF)
check_function_exists(mmap            LIBVNCSERVER_HAVE_MMAP)
check_function_exists(fork            LIBVNCSERVER_HAVE_FORK)
check_function_exists(ftime           LIBVNCSERVER_HAVE_FTIME)
check_function_exists(gethostbyname   LIBVNCSERVER_HAVE_GETHOSTBYNAME)
check_function_exists(gethostname     LIBVNCSERVER_HAVE_GETHOSTNAME)
check_function_exists(inet_ntoa       LIBVNCSERVER_HAVE_INET_NTOA)
check_function_exists(memmove         LIBVNCSERVER_HAVE_MEMMOVE)
check_function_exists(memset          LIBVNCSERVER_HAVE_MEMSET)
check_function_exists(mkfifo          LIBVNCSERVER_HAVE_MKFIFO)
check_function_exists(poll            LIBVNCSERVER_HAVE_POLL)
check_function_exists(select          LIBVNCSERVER_HAVE_SELECT)
check_function_exists(socket          LIBVNCSERVER_HAVE_SOCKET)
check_function_exists(strchr          LIBVNCSERVER_HAVE_STRCHR)
check_function_exists(strcspn         LIBVNCSERVER_HAVE_STRCSPN)
check_function_exists(strdup          LIBVNCSERVER_HAVE_STRDUP)
check_function_exists(strerror        LIBVNCSERVER_HAVE_STRERROR)
check_function_exists(strstr          LIBVNCSERVER_HAVE_STRSTR)

check_symbol_exists(htobe64 "endian.h" LIBVNCSERVER_HAVE_HTOBE64)
check_symbol_exists(OSSwapHostToBigInt64 "libkern/OSByteOrder.h" LIBVNCSERVER_HAVE_OSSWAPHOSTTOBIGINT64)

if(LIBVNCSERVER_HAVE_SYS_SOCKET_H)
	# socklen_t
	list(APPEND CMAKE_EXTRA_INCLUDE_FILES "sys/socket.h")
endif()
if(HAVE_ARPA_INET_H)
	# in_addr_t
	list(APPEND CMAKE_EXTRA_INCLUDE_FILES "arpa/inet.h")
endif()

check_type_size(pid_t     LIBVNCSERVER_PID_T)
check_type_size(size_t    LIBVNCSERVER_SIZE_T)
check_type_size(socklen_t LIBVNCSERVER_SOCKLEN_T)
check_type_size(in_addr_t LIBVNCSERVER_IN_ADDR_T)
if(NOT HAVE_LIBVNCSERVER_IN_ADDR_T)
	set(LIBVNCSERVER_NEED_INADDR_T 1)
endif()

test_big_endian(LIBVNCSERVER_WORDS_BIGENDIAN)

find_package(ZLIB REQUIRED)
find_package(PNG REQUIRED)
find_package(JPEG REQUIRED)
find_package(LZO REQUIRED)
set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
find_package(Threads REQUIRED)

set(_RFB_RFBCONFIG_H TRUE)
set(LIBVNCSERVER_HAVE_LIBJPEG TRUE)
set(LIBVNCSERVER_HAVE_LZO TRUE)
set(LIBVNCSERVER_HAVE_LIBPNG TRUE)
set(LIBVNCSERVER_HAVE_LIBPTHREAD TRUE)
set(LIBVNCSERVER_HAVE_LIBZ TRUE)
set(LIBVNCSERVER_HAVE_LIBSSL TRUE)
set(LIBVNCSERVER_ALLOW24BPP TRUE)
set(LIBVNCSERVER_IPv6 TRUE)

file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/rfb)
configure_file(${CMAKE_SOURCE_DIR}/3rdparty/libvncserver/rfb/rfbconfig.h.cmakein ${CMAKE_CURRENT_BINARY_DIR}/rfb/rfbconfig.h @ONLY)
