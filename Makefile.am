# Copyright (c) 2013-2016 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

ACLOCAL_AMFLAGS = -I build-aux/m4
SUBDIRS = src
if ENABLE_MAN
SUBDIRS += doc/man
endif
.PHONY: deploy FORCE

GZIP_ENV="-9n"
export PYTHONPATH

if BUILD_SCRIPT_LIBS
pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = libscriptconsensus.pc
endif

SCRIPTD_BIN=$(top_builddir)/src/$(SCRIPT_DAEMON_NAME)$(EXEEXT)
SCRIPT_CLI_BIN=$(top_builddir)/src/$(SCRIPT_CLI_NAME)$(EXEEXT)
SCRIPT_WIN_INSTALLER=$(PACKAGE)-$(PACKAGE_VERSION)-win$(WINDOWS_BITS)-setup$(EXEEXT)

empty :=
space := $(empty) $(empty)

DIST_DOCS = $(wildcard doc/*.md) $(wildcard doc/release-notes/*.md)
DIST_CONTRIB = $(top_srcdir)/contrib/script-cli.bash-completion \
	       $(top_srcdir)/contrib/script-tx.bash-completion \
	       $(top_srcdir)/contrib/scriptd.bash-completion \
	       $(top_srcdir)/contrib/init \
	       $(top_srcdir)/contrib/rpm

BIN_CHECKS=$(top_srcdir)/contrib/devtools/symbol-check.py \
           $(top_srcdir)/contrib/devtools/security-check.py

WINDOWS_PACKAGING = $(top_srcdir)/share/pixmaps/script.ico \
  $(top_srcdir)/share/pixmaps/nsis-header.bmp \
  $(top_srcdir)/share/pixmaps/nsis-wizard.bmp \
  $(top_srcdir)/doc/README_windows.txt

COVERAGE_INFO = baseline_filtered_combined.info baseline.info \
  leveldb_baseline.info test_script_filtered.info total_coverage.info \
  baseline_filtered.info rpc_test.info rpc_test_filtered.info \
  leveldb_baseline_filtered.info test_script_coverage.info test_script.info

dist-hook:
	-$(GIT) archive --format=tar HEAD -- src/clientversion.cpp | $(AMTAR) -C $(top_distdir) -xf -

$(SCRIPT_WIN_INSTALLER): all-recursive
	$(MKDIR_P) $(top_builddir)/release
	STRIPPROG="$(STRIP)" $(INSTALL_STRIP_PROGRAM) $(SCRIPTD_BIN) $(top_builddir)/release
	STRIPPROG="$(STRIP)" $(INSTALL_STRIP_PROGRAM) $(SCRIPT_CLI_BIN) $(top_builddir)/release
	@test -f $(MAKENSIS) && $(MAKENSIS) -V2 $(top_builddir)/share/setup.nsi || \
	  echo error: could not build $@
	@echo built $@

if TARGET_WINDOWS
deploy: $(SCRIPT_WIN_INSTALLER)
endif

$(SCRIPTD_BIN): FORCE
	$(MAKE) -C src $(@F)

$(SCRIPT_CLI_BIN): FORCE
	$(MAKE) -C src $(@F)

if USE_LCOV

baseline.info:
	$(LCOV) -c -i -d $(abs_builddir)/src -o $@

baseline_filtered.info: baseline.info
	$(LCOV) -r $< "/usr/include/*" -o $@

leveldb_baseline.info: baseline_filtered.info
	$(LCOV) -c -i -d $(abs_builddir)/src/leveldb -b $(abs_builddir)/src/leveldb -o $@

leveldb_baseline_filtered.info: leveldb_baseline.info
	$(LCOV) -r $< "/usr/include/*" -o $@

baseline_filtered_combined.info: leveldb_baseline_filtered.info baseline_filtered.info
	$(LCOV) -a leveldb_baseline_filtered.info -a baseline_filtered.info -o $@

test_script.info: baseline_filtered_combined.info
	$(MAKE) -C src/ check
	$(LCOV) -c -d $(abs_builddir)/src -t test_script -o $@
	$(LCOV) -z -d $(abs_builddir)/src
	$(LCOV) -z -d $(abs_builddir)/src/leveldb

test_script_filtered.info: test_script.info
	$(LCOV) -r $< "/usr/include/*" -o $@

rpc_test.info: test_script_filtered.info
	-@TIMEOUT=15 python qa/pull-tester/rpc-tests.py $(EXTENDED_RPC_TESTS)
	$(LCOV) -c -d $(abs_builddir)/src --t rpc-tests -o $@
	$(LCOV) -z -d $(abs_builddir)/src
	$(LCOV) -z -d $(abs_builddir)/src/leveldb

rpc_test_filtered.info: rpc_test.info
	$(LCOV) -r $< "/usr/include/*" -o $@

test_script_coverage.info: baseline_filtered_combined.info test_script_filtered.info
	$(LCOV) -a baseline_filtered.info -a leveldb_baseline_filtered.info -a test_script_filtered.info -o $@

total_coverage.info: baseline_filtered_combined.info test_script_filtered.info rpc_test_filtered.info
	$(LCOV) -a baseline_filtered.info -a leveldb_baseline_filtered.info -a test_script_filtered.info -a rpc_test_filtered.info -o $@ | $(GREP) "\%" | $(AWK) '{ print substr($$3,2,50) "/" $$5 }' > coverage_percent.txt

test_script.coverage/.dirstamp:  test_script_coverage.info
	$(GENHTML) -s $< -o $(@D)
	@touch $@

total.coverage/.dirstamp: total_coverage.info
	$(GENHTML) -s $< -o $(@D)
	@touch $@

cov: test_script.coverage/.dirstamp total.coverage/.dirstamp

endif

dist_noinst_SCRIPTS = autogen.sh

EXTRA_DIST = $(top_srcdir)/share/genbuild.sh qa/pull-tester/rpc-tests.py qa/rpc-tests $(DIST_CONTRIB) $(DIST_DOCS) $(WINDOWS_PACKAGING) $(BIN_CHECKS)

CLEANFILES = $(SCRIPT_WIN_INSTALLER)

# This file is problematic for out-of-tree builds if it exists.
DISTCLEANFILES = qa/pull-tester/tests_config.pyc

.INTERMEDIATE: $(COVERAGE_INFO)

DISTCHECK_CONFIGURE_FLAGS = --enable-man

clean-local:
	rm -rf coverage_percent.txt test_script.coverage/ total.coverage/ qa/tmp/ cache/
	rm -rf qa/pull-tester/__pycache__
