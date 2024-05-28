# Copyright (c) 2013-2016 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS)
AM_CXXFLAGS = $(HARDENED_CXXFLAGS) $(ERROR_CXXFLAGS)
AM_CPPFLAGS = $(HARDENED_CPPFLAGS)
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

SCRIPT_CONFIG_INCLUDES=-I$(builddir)/config
SCRIPT_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

SCRIPT_INCLUDES += -I$(srcdir)/secp256k1/include
SCRIPT_INCLUDES += $(UNIVALUE_CFLAGS)

LIBSCRIPT_SERVER=libscript_server.a
LIBSCRIPT_COMMON=libscript_common.a
LIBSCRIPT_CONSENSUS=libscript_consensus.a
LIBSCRIPT_CLI=libscript_cli.a
LIBSCRIPT_UTIL=libscript_util.a
LIBSCRIPT_CRYPTO=crypto/libscript_crypto.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBSCRIPT_ZMQ=libscript_zmq.a
endif
if BUILD_SCRIPT_LIBS
LIBSCRIPTCONSENSUS=libscriptconsensus.la
endif
if ENABLE_WALLET
LIBSCRIPT_WALLET=libscript_wallet.a
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBSCRIPT_CRYPTO) \
  $(LIBSCRIPT_UTIL) \
  $(LIBSCRIPT_COMMON) \
  $(LIBSCRIPT_CONSENSUS) \
  $(LIBSCRIPT_SERVER) \
  $(LIBSCRIPT_CLI) \
  $(LIBSCRIPT_WALLET) \
  $(LIBSCRIPT_ZMQ)

lib_LTLIBRARIES = $(LIBSCRIPTCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_SCRIPTD
  bin_PROGRAMS += scriptd
endif

if BUILD_SCRIPT_UTILS
  bin_PROGRAMS += script-cli script-tx
endif

.PHONY: FORCE check-symbols check-security
# script core #
SCRIPT_CORE_H = \
  addrdb.h \
  addrman.h \
  base58.h \
  bloom.h \
  blockencodings.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coins.h \
  compat.h \
  compat/byteswap.h \
  compat/endian.h \
  compat/sanity.h \
  compressor.h \
  consensus/consensus.h \
  core_io.h \
  core_memusage.h \
  cuckoocache.h \
  script-fees.cpp \
  script-fees.h \
  httprpc.h \
  httpserver.h \
  indirectmap.h \
  init.h \
  key.h \
  keystore.h \
  dbwrapper.h \
  limitedmap.h \
  memusage.h \
  merkleblock.h \
  miner.h \
  net.h \
  net_processing.h \
  netaddress.h \
  netbase.h \
  netmessagemaker.h \
  noui.h \
  policy/fees.h \
  policy/policy.h \
  policy/rbf.h \
  pow.h \
  protocol.h \
  random.h \
  reverselock.h \
  rpc/client.h \
  rpc/protocol.h \
  rpc/server.h \
  rpc/register.h \
  scheduler.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  script/ismine.h \
  streams.h \
  support/allocators/secure.h \
  support/allocators/zeroafterfree.h \
  support/cleanse.h \
  support/events.h \
  support/lockedpool.h \
  sync.h \
  threadsafety.h \
  threadinterrupt.h \
  timedata.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  undo.h \
  util.h \
  utilmoneystr.h \
  utiltime.h \
  validation.h \
  validationinterface.h \
  versionbits.h \
  wallet/coincontrol.h \
  wallet/crypter.h \
  wallet/db.h \
  wallet/rpcwallet.h \
  wallet/wallet.h \
  wallet/walletdb.h \
  warnings.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h\
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h


obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh $(abs_top_builddir)/src/obj/build.h \
	  $(abs_top_srcdir)
libscript_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between scriptd and script-qt
libscript_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libscript_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libscript_server_a_SOURCES = \
  addrman.cpp \
  addrdb.cpp \
  bloom.cpp \
  blockencodings.cpp \
  chain.cpp \
  checkpoints.cpp \
  httprpc.cpp \
  httpserver.cpp \
  init.cpp \
  dbwrapper.cpp \
  merkleblock.cpp \
  miner.cpp \
  net.cpp \
  net_processing.cpp \
  noui.cpp \
  policy/fees.cpp \
  policy/policy.cpp \
  pow.cpp \
  rest.cpp \
  rpc/blockchain.cpp \
  rpc/mining.cpp \
  rpc/misc.cpp \
  rpc/net.cpp \
  rpc/rawtransaction.cpp \
  rpc/server.cpp \
  script/sigcache.cpp \
  script/ismine.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  ui_interface.cpp \
  validation.cpp \
  validationinterface.cpp \
  versionbits.cpp \
  $(SCRIPT_CORE_H)

if ENABLE_ZMQ
libscript_zmq_a_CPPFLAGS = $(SCRIPT_INCLUDES) $(ZMQ_CFLAGS)
libscript_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libscript_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp
endif


# wallet: shared between scriptd and script-qt, but only linked
# when wallet enabled
libscript_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES)
libscript_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libscript_wallet_a_SOURCES = \
  wallet/crypter.cpp \
  wallet/db.cpp \
  wallet/rpcdump.cpp \
  wallet/rpcwallet.cpp \
  wallet/wallet.cpp \
  wallet/walletdb.cpp \
  policy/rbf.cpp \
  $(SCRIPT_CORE_H)

# crypto primitives library
crypto_libscript_crypto_a_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_CONFIG_INCLUDES)
crypto_libscript_crypto_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libscript_crypto_a_SOURCES = \
  crypto/aes.cpp \
  crypto/aes.h \
  crypto/common.h \
  crypto/hmac_sha256.cpp \
  crypto/hmac_sha256.h \
  crypto/hmac_sha512.cpp \
  crypto/hmac_sha512.h \
  crypto/ripemd160.cpp \
  crypto/ripemd160.h \
  crypto/sha1.cpp \
  crypto/sha1.h \
  crypto/sha256.cpp \
  crypto/sha256.h \
  crypto/sha512.cpp \
  crypto/sha512.h

# consensus: shared between all executables that validate any consensus rules.
libscript_consensus_a_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES)
libscript_consensus_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libscript_consensus_a_SOURCES = \
  amount.h \
  arith_uint256.cpp \
  arith_uint256.h \
  consensus/merkle.cpp \
  consensus/merkle.h \
  consensus/params.h \
  consensus/validation.h \
  hash.cpp \
  hash.h \
  prevector.h \
  primitives/block.cpp \
  primitives/block.h \
  primitives/transaction.cpp \
  primitives/transaction.h \
  pubkey.cpp \
  pubkey.h \
  script/scriptconsensus.cpp \
  script/interpreter.cpp \
  script/interpreter.h \
  script/script.cpp \
  script/script.h \
  script/script_error.cpp \
  script/script_error.h \
  serialize.h \
  tinyformat.h \
  uint256.cpp \
  uint256.h \
  utilstrencodings.cpp \
  utilstrencodings.h \
  version.h

# common: shared between scriptd, and script-qt and non-server tools
libscript_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES)
libscript_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libscript_common_a_SOURCES = \
  amount.cpp \
  base58.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  core_read.cpp \
  core_write.cpp \
  key.cpp \
  keystore.cpp \
  netaddress.cpp \
  netbase.cpp \
  protocol.cpp \
  scheduler.cpp \
  script/sign.cpp \
  script/standard.cpp \
  warnings.cpp \
  $(SCRIPT_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libscript_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES)
libscript_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libscript_util_a_SOURCES = \
  support/lockedpool.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  random.cpp \
  rpc/protocol.cpp \
  support/cleanse.cpp \
  sync.cpp \
  threadinterrupt.cpp \
  util.cpp \
  utilmoneystr.cpp \
  utilstrencodings.cpp \
  utiltime.cpp \
  $(SCRIPT_CORE_H)

if GLIBC_BACK_COMPAT

libscript_util_a_SOURCES += compat/glibc_compat.cpp
AM_LDFLAGS += $(COMPAT_LDFLAGS)

endif

# cli: shared between script-cli and script-qt
libscript_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES)
libscript_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libscript_cli_a_SOURCES = \
  rpc/client.cpp \
  $(SCRIPT_CORE_H)

nodist_libscript_util_a_SOURCES = $(srcdir)/obj/build.h
#

# scriptd binary #
scriptd_SOURCES = scriptd.cpp
scriptd_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES)
scriptd_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
scriptd_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
scriptd_SOURCES += scriptd-res.rc
endif

scriptd_LDADD = \
  $(LIBSCRIPT_SERVER) \
  $(LIBSCRIPT_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBSCRIPT_UTIL) \
  $(LIBSCRIPT_WALLET) \
  $(LIBSCRIPT_ZMQ) \
  $(LIBSCRIPT_CONSENSUS) \
  $(LIBSCRIPT_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

scriptd_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# script-cli binary #
script_cli_SOURCES = script-cli.cpp
script_cli_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES) $(EVENT_CFLAGS)
script_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
script_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
script_cli_SOURCES += script-cli-res.rc
endif

script_cli_LDADD = \
  $(LIBSCRIPT_CLI) \
  $(LIBUNIVALUE) \
  $(LIBSCRIPT_UTIL) \
  $(LIBSCRIPT_CRYPTO)

script_cli_LDADD += $(BOOST_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# script-tx binary #
script_tx_SOURCES = script-tx.cpp
script_tx_CPPFLAGS = $(AM_CPPFLAGS) $(SCRIPT_INCLUDES)
script_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
script_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
script_tx_SOURCES += script-tx-res.rc
endif

script_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBSCRIPT_COMMON) \
  $(LIBSCRIPT_UTIL) \
  $(LIBSCRIPT_CONSENSUS) \
  $(LIBSCRIPT_CRYPTO) \
  $(LIBSECP256K1)

script_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# scriptconsensus library #
if BUILD_SCRIPT_LIBS
include_HEADERS = script/scriptconsensus.h
libscriptconsensus_la_SOURCES = $(crypto_libscript_crypto_a_SOURCES) $(libscript_consensus_a_SOURCES)

if GLIBC_BACK_COMPAT
  libscriptconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libscriptconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libscriptconsensus_la_LIBADD = $(LIBSECP256K1)
libscriptconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_SCRIPT_INTERNAL
libscriptconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CTAES_DIST =  crypto/ctaes/bench.c
CTAES_DIST += crypto/ctaes/ctaes.c
CTAES_DIST += crypto/ctaes/ctaes.h
CTAES_DIST += crypto/ctaes/README.md
CTAES_DIST += crypto/ctaes/test.c

CLEANFILES = $(EXTRA_LIBRARIES)

CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += consensus/*.gcda consensus/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += policy/*.gcda policy/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += support/*.gcda support/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += wallet/*.gcda wallet/*.gcno
CLEANFILES += wallet/test/*.gcda wallet/test/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno

DISTCLEANFILES = obj/build.h

EXTRA_DIST = $(CTAES_DIST)


config/script-config.h: config/stamp-h1
	@$(MAKE) -C $(top_builddir) $(subdir)/$(@)
config/stamp-h1: $(top_srcdir)/$(subdir)/config/script-config.h.in $(top_builddir)/config.status
	$(AM_V_at)$(MAKE) -C $(top_builddir) $(subdir)/$(@)
$(top_srcdir)/$(subdir)/config/script-config.h.in:  $(am__configure_deps)
	$(AM_V_at)$(MAKE) -C $(top_srcdir) $(subdir)/config/script-config.h.in

clean-local:
	-$(MAKE) -C secp256k1 clean
	-$(MAKE) -C univalue clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h
	-rm -rf test/__pycache__

.rc.o:
	@test -f $(WINDRES)
	## FIXME: How to get the appropriate modulename_CPPFLAGS in here?
	$(AM_V_GEN) $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CPPFLAGS) -DWINDRES_PREPROC -i $< -o $@

.mm.o:
	$(AM_V_CXX) $(OBJCXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	  $(CPPFLAGS) $(AM_CXXFLAGS) $(AM_CXXFLAGS) $(PIE_FLAGS) $(CXXFLAGS) -c -o $@ $<

check-symbols: $(bin_PROGRAMS)
if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(top_srcdir)/contrib/devtools/symbol-check.py < $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) $(top_srcdir)/contrib/devtools/security-check.py < $(bin_PROGRAMS)
endif

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(<D) $<

if EMBEDDED_LEVELDB
include Makefile.leveldb.include
endif

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_BENCH
include Makefile.bench.include
endif
