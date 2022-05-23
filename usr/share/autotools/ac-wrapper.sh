#!/bin/bash
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/sys-devel/autoconf-wrapper/files/ac-wrapper-4.sh,v 1.3 2006/11/17 20:17:07 vapier Exp $

# Based on the ac-wrapper.pl script provided by MandrakeSoft
# Rewritten in bash by Gregorio Guidi
#
# Executes the correct autoconf version.
#
# - defaults to newest version available (hopefully autoconf-2.60)
# - runs autoconf 2.13 if:
#   - envvar WANT_AUTOCONF is set to `2.1'
#     -or-
#   - `ac{local,include}.m4' or `configure.{in,ac}' have AC_PREREQ(2.1) (not higher)
#     -or-
#   - `configure' is already present and was generated by autoconf 2.13

if [[ ${0##*/} == "ac-wrapper.sh" ]] ; then
	echo "Don't call this script directly" >&2
	exit 1
fi

if [[ ${WANT_AUTOCONF} == "2.1" && ${0##*/} == "autom4te" ]] ; then
	echo "ac-wrapper: Autoconf 2.13 doesn't contain autom4te." >&2
	echo "            Either unset WANT_AUTOCONF or don't execute anything" >&2
	echo "            that would use autom4te." >&2
	exit 1
fi

#
# Set up bindings between actual version and WANT_AUTOCONF
#
vers="2.61:2.5 2.60:2.5 2.59:2.5 2.5x:2.5 2.13:2.1"

binary=""
for v in ${vers} ; do
	auto_ver=${v%:*}
	if [ -z "${binary}" ] && [ -x "${0}-${auto_ver}" ] ; then
		binary="${0}-${auto_ver}"
	fi
done
if [ -z "${binary}" ] ; then
	echo "ac-wrapper: Unable to locate any usuable version of autoconf." >&2
	echo "            I tried these versions: ${vers}" >&2
	echo "            With a base name of '${0}'." >&2
	exit 1
fi

#
# Check the WANT_AUTOCONF setting.  We accept a whitespace delimited
# list of autoconf versions.
#
if [ -n "${WANT_AUTOCONF}" ] ; then
	for v in ${vers} x ; do
		if [ "${v}" = "x" ] ; then
			echo "ac-wrapper: warning: invalid WANT_AUTOCONF '${WANT_AUTOCONF}'; ignoring." >&2
			unset WANT_AUTOCONF
			break
		fi

		auto_ver=${v%:*}
		want_ver=${v#*:}
		for wx in ${WANT_AUTOCONF} ; do
			if [ "${wx}" = "${want_ver}" ] && [ -x "${0}-${auto_ver}" ] ; then
				binary="${0}-${auto_ver}"
				v="x"
			fi
		done
		[ "${v}" = "x" ] && break
	done
fi

#
# autodetect helpers
#
acprereq_version() {
	gawk \
	'($0 !~ /^[[:space:]]*(#|dnl)/) {
		if (match($0, "AC_PREREQ\\(\\[?([0-9]\\.[0-9])", res))
			VERSIONS[COUNT++] = res[1]
	}

	END {
		asort(VERSIONS)
		print VERSIONS[COUNT]
	}' "$@"
}

generated_version() {
	gawk \
	'{
		if (match($0,
		          "^# Generated (by (GNU )?Autoconf|automatically using autoconf version) ([0-9].[0-9])",
		          res)) {
			print res[3]
			exit
		}
	}' "$@"
}

#
# autodetect routine
#
if [[ ${WANT_AUTOCONF} == "2.1" ]] && [ -f "configure.ac" ] ; then
	echo "ac-wrapper: Since configure.ac is present, aclocal always use" >&2
	echo "            autoconf 2.59+, which conflicts with your choice and" >&2
	echo "            causes error. You have two options:" >&2
	echo "            1. Try execute command again after removing configure.ac" >&2
	echo "            2. Don't set WANT_AUTOCONF" >&2
	exit 1
fi

if [[ ${WANT_AUTOCONF} != "2.5" ]] && [[ -n ${WANT_AUTOMAKE} ]] ; then
	# Automake-1.7 and better require autoconf-2.5x so if WANT_AUTOMAKE
	# is set to an older version, let's do some sanity checks.
	case "${WANT_AUTOMAKE}" in
	1.[456])
		acfiles=$(ls ac{local,include}.m4 configure.{in,ac} 2>/dev/null)
		[[ -n ${acfiles} ]] && confversion=$(acprereq_version ${acfiles})
		
		[[ -z ${confversion} && -r "configure" ]] \
			&& confversion=$(generated_version configure)

		if [[ ${confversion} == "2.1" && ! -f "configure.ac" ]] ; then
			binary="${0}-2.13"
		fi
	esac
fi

if [[ -n ${WANT_ACWRAPPER_DEBUG} ]] ; then
	if [[ -n ${WANT_AUTOCONF} ]] ; then
		echo "ac-wrapper: DEBUG: WANT_AUTOCONF is set to ${WANT_AUTOCONF}" >&2
	fi
	echo "ac-wrapper: DEBUG: will execute <${binary}>" >&2
fi

#
# for further consistency
#
for v in ${vers} ; do
	auto_ver=${v%:*}
	want_ver=${v#*:}
	if [ "${binary}" = "${0}-${auto_ver}" ] ; then
		export WANT_AUTOMAKE="${want_ver}"
	fi
done

#
# Now try to run the binary
#
if [[ ! -x ${binary} ]] ; then
	# this shouldn't happen
	echo "ac-wrapper: ${binary} is missing or not executable." >&2
	echo "            Please try emerging the correct version of autoconf." >&2
	exit 1
fi

exec "${binary}" "$@"

echo "ac-wrapper: was unable to exec ${binary} !?" >&2
exit 1
