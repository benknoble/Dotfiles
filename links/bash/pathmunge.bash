#! /usr/bin/env bash

# This shell script contains two different major path munging functions:
# splice
# pathmunge

# These two functions take the following verbs
# path - to supply an initial path, otherwise use PATH
# usage, help - print out a help message on how to use them.
# print, show, list - print out the current path.
# remove, delete - remove the given elements from the path.
# append, prepend - add new elements to the start or end of the path.
# before, after - move (splice) or move/add (pathmunge) new elements to
#                 before or after the given element.
# shift - remove first item from path
# unshift - add new elements to the start of the path
# pop - remove last item from path
# push - add new elements to the end of the path.

splice_debug=0

splice_debug () {
    [ ${splice_debug} -ne 0 ] && echo "$@" >&2
}

remove_superfluous_colons () {
    local path="$1"

    # Remove superfluous : characters from path.
    # First remove the ones from the beginning.
    # Second remove ones from the end.
    # Third remove double colons from the middle.
    while true; do
        case "${path}" in
            :*)
                path="${path#:}"
                ;;
            *)
                break
                ;;
        esac
    done

    while true; do
        case "${path}" in
            *:)
                path="${path%:}"
                ;;
            *)
                break
                ;;
        esac
    done

    while true; do
        case "${path}" in
            *::*)
                path="${path//::/:}"
                ;;
            *)
                break
                ;;
        esac
    done

    echo "${path}"
}

# verbs in this script can zero, one or two
# leading dashes.
verbify () {
    local verb="$1"

    while true; do
        case "${verb}" in
            -*)
                verb=${verb#-}
                ;;
            *)
                break
                ;;
        esac
    done

    echo "${verb}"
}

# splice
# splice the path with a set of atomic operations including
# prepend and append for adding new elements to the path.
# before and after for moving existing elements around in the path.
# print, show, list all echo the current path.
# remove, delete remove the existing elements from the path.
# usage, help print out a usage message.
splice () {
    local path="${PATH}" newpath location
    local setpath="yes"
    # These next three are used in a swap.
    local first middle last
    # n is used for shift, pop
    local n=1

    case $(verbify "$1") in
        verbose|-verbose|--verbose|debug|-debug|--debug)
            splice_debug=1
            shift
            ;;
        *)
            ;;
    esac

    # Does the user wish to build a different path?
    case $(verbify "$1") in
        path|-path|--path)
            path="$2"
            setpath="no"
            shift shift
            ;;
        *)
            ;;
    esac

    # Unload path

    path=$(remove_superfluous_colons "${path}")

    # Now make sure that we have one leading and trailing :
    path=:${path}:
    splice_debug "splice: path is now ${path}"

    # The location is next and is specified with or without --
    verb=$(verbify "$1")
    shift

    # Check the verb's validity.
    # In the case of before and after ensure that the element before or after which
    # the given elements are placed actually exists in the path.
    case ${verb} in
        usage|help)
            echo "Usage: splice ():" >&2
            echo >&2
            echo "splice adds, deletes and moves elements around in a colon-delimited path" >&2
            echo "splice will not insert a missing element with a move command." >&2
            echo "New elements must be added with prepend or append before being moved." >&2
            echo >&2
            echo "splice [ verbose ] [ path initial ] [ prepend | unshift | append | push | remove | delete ] [ element+ ]" >&2
            echo "splice [ verbose ] [ path initial ] [ print | show | list ]" >&2
            echo "splice [ verbose ] [ path initial ] [ before | after ] [ element ] [ element+ ]" >&2
            echo "splice [ verbose ] [ path initial ] [ start | end ]" >&2
            echo "splice [ verbose ] [ path initial ] [ swap ] [ element1 ] [ element2 ]" >&2
            echo "splice [ verbose ] [ path initial ] [ shift ] [ n ]" >&2
            echo "splice [ verbose ] [ path initial ] [ pop ] [ n ]" >&2
            echo "splice [ verbose ] [ path initial ] [ usempi ] [ MPI-variant | list ]" >&2
            echo >&2
            echo "verbose - turn on debugging messages about what is happening inside function" >&2
            echo "path - set the starting path to initial. New path is echoed to stdout" >&2
            echo "       otherwise, start with PATH and set PATH to new value." >&2
            echo "prepend,unshift - add elements one at a time to the beginning of path" >&2
            echo "append,push - add elements one at a time to the end of path" >&2
            echo "print, show, list - echo path to stdout" >&2
            echo "remove, delete - remove the elements from path" >&2
            echo "before - insert elements one at a time before the element given." >&2
            echo "after - insert elements one at a time after the element given." >&2
            echo "start - move the given element to the start of the path." >&2
            echo "end - move the given element to the end of the path." >&2
            echo "swap - swap the locations of the two elements given in the path." >&2
            echo "shift - remove 'n' items from start of path. n defaults to 1." >&2
            echo "pop - remove 'n' items from end of path. n defaults to 1." >&2
            echo "usempi - from a list of MPI variants registered with mpi-selector" >&2
            echo "         use the requested one by prepending its paths." >&2
            echo "         If list is given, it lists the variants known to mpi-selector." >&2;
            echo >&2
            echo "All path elements must be one path element. Elements with a ':'" >&2
            echo "are ignored." >&2
            echo >&2
            echo "The current path is set to:" >&2
            path=$(remove_superfluous_colons ${path})
            echo "${path}" >&2
            splice_debug=0
            return 0
            ;;
        before|after)
            another="$1"
            splice_debug "splice: another is: ${another}"
            shift
            case :${path}: in
                *:${another}:*)
                    splice_debug "splice: Found ${another} in path"
                    ;;
                *)
                    [ -t 2 ] && echo "Warning: Unable to find ${another} in path." >&2
                    path=${path%:}
                    path=${path#:}
                    echo ${path}
                    splice_debug=0
                    return 1
                    ;;
            esac
            ;;
        print|show|list)
            path=${path#:}
            path=${path%:}
            echo "${path}"
            splice_debug=0
            return 0
            ;;
        usempi)
            # This is a special case to allow quick PATH switches.
            local mpiselect= mpidatadir= mpivariant= result=
            mpiselect=$(type -path mpi-selector)
            mpidatadir=$(/bin/grep 'my \$data_dir = ' ${mpiselect})
            if [ ! -n "${mpidatadir}" ]; then
                echo "Unable to find MPI selector data directory." >&2
                return 2
            fi

            mpidatadir=${mpidatadir##* \"}
            mpidatadir="${mpidatadir%\"}"
            # echo "We think that the mpi-selector data directory is: ${mpidatadir}"
            if cd ${mpidatadir} &> /dev/null; then
                    :
            else
                echo "Unable to cd to mpi-selector data directory." >&2
                return 1
            fi

            if [ "${1}" = "list" ]; then
                /bin/ls -C *.sh | /bin/sed -e 's@\.sh$@@g' -e 's@\.sh[[:space:]]@ @g'
                cd - &> /dev/null
                return 0
            fi

            mpivariant="${1}"
            if [ -z "${mpivariant}" ]; then
                echo "No MPI variant requested" >&2
                cd - &> /dev/null
                return 1
            fi

            case ${mpivariant} in
                */*)
                    echo "No directories allowed in MPI variant" >&2
                    cd - &> /dev/null
                    return 1
                    ;;
                *)
                ;;
            esac

            if [ -f "./${mpivariant}.sh" ]; then
                echo "Use MPI variant ${mpivariant}" >&2
                . ./${mpivariant}.sh
                result=0
            elif [ -f "./${mpivariant}" ]; then
                echo "Use MPI variant ${mpivariant%.sh}" >&2
                . ./${mpivariant}
                result=0
            else
                echo "Unable to find requested MPI variant: ${mpivariant}" >&2
            fi
            cd - &> /dev/null
            return ${result}
            ;;
        start|end|remove|delete|prepend|append|unshift|push)
            ;;
        shift)
            if [ $# -gt 1 ]; then
                echo "splice shift takes at most one argument, n, the number of elements to remove." >&2
                return 1
            elif [ $# -eq 0 ]; then
                :
            else
                case "${1}" in
                [0-9]|[0-9][0-9]|[0-9][0-9][0-9])
                    n="${1}"
                    shift
                    ;;
                *)
                    echo "splice shift takes a non-negative numerical argument." >&2
                    shift
                    return 2
                    ;;
                esac
            fi
            while [ ${n} -gt 0 ]; do
                # Remember here that path has a ':' prepended and appended while working.
                case ${path} in
                :*:*:)
                    # Strip the leading ':' off, so we can pattern-match off the first element.
                    path=${path#:}
                    splice_debug "splice: shift: remove first element from path: ${path%%:*}"
                    # Pull out the first element, then prepend a ':'.
                    path=${path:+:}${path#*:}
                    ;;
                *)
                    path=''
                    ;;
                esac
                n=$[n - 1]
            done
            ;;
        pop)
            if [ $# -gt 1 ]; then
                echo "splice pop takes at most one argument, n, the number of elements to remove." >&2
                return 1
            elif [ $# -eq 0 ]; then
                :
            else
                case "${1}" in
                [0-9]|[0-9][0-9]|[0-9][0-9][0-9])
                    n="${1}"
                    shift
                    ;;
                *)
                    echo "splice pop takes a non-negative numerical argument." >&2
                    shift
                    return 2
                    ;;
                esac
            fi
            while [ ${n} -gt 0 ]; do
                # Remember here that path has a ':' appended and prepended while working.
                case ${path} in
                :*:*:)
                    # Strip the trailing ':' off, so we can pattern match off the last element.
                    path=${path%:}
                    splice_debug "splice: pop:  prune last element from path: ${path##*:}"
                    # Pull off the last element, then append a ':' again.
                    path=${path%:*}${path:+:}
                    ;;
                *)
                    path=''
                    ;;
                esac
                n=$[n - 1]
            done
            ;;
        swap)
            # This one is peculiar, because it only takes two elements.
            if [ $# -ne 2 ]; then
                echo "splice: swap verb takes exactly two path elements as arguments" >&2
                echo "${path}"
                splice_debug=0
                return 4
            fi

            if [ ! -d "${1}"/. ]; then
                echo "splice: first path element for swap does not exist as a directory." >&2;
                echo "${path}"
                splice_debug=0
                return 5
            fi

            if [ ! -d "${2}"/. ]; then
                echo "splice: second path element for swap does not exist as a directory." >&2;
                echo "${path}"
                splice_debug=0
                return 6
            fi

            splice_debug "splice: swap two existing elements in path"
            case "${path}" in
                *:${1}:${2}:*|*:${1}:*:${2}:*)
                    splice_debug "splice: Case #1"
                    first="${path%%:${1}:*}"
                    middle=":${path#*:${1}:}"
                    splice_debug "splice: middle starts as ${middle}"
                    middle="${middle%:${2}:*}"
                    last="${path##*:${2}:}"
                    splice_debug "splice: first = ${first}"
                    splice_debug "splice: middle = ${middle}"
                    splice_debug "splice: last = ${last}"
                    path="${first}:${2}${middle}:${1}:${last}"
                    ;;
                *:${2}:${1}:*|*:${2}:*:${1}:*)
                    splice_debug "splice: Case #2"
                    first="${path%%:${2}:*}"
                    middle=":${path#*:${2}:}"
                    splice_debug "splice: middle starts as ${middle}"
                    middle="${middle%:${1}:*}"
                    last="${path##*:${1}:}"
                    splice_debug "splice: first = ${first}"
                    splice_debug "splice: middle = ${middle}"
                    splice_debug "splice: last = ${last}"
                    path="${first}:${1}${middle}:${2}:${last}"
                    ;;
                *)
                    echo "Unable to find one or both path elements already in path." >&2
                    echo "${path}"
                    splice_debug=0
                    return 7
                    ;;
            esac
            shift shift
            ;;
        *)
            [ -t 2 ] && echo "Error: Bad verb ${verb} given for element location" >&2;
            echo ${path}
            splice_debug=0
            return 1
            ;;
    esac

    # Run through each element in the list.
    # This should be skipped during a swap.
    for element in "$@"; do
        splice_debug "splice: element is: ${element}"
        # First make sure that the thing we want to move is in the path
        if [ "${verb}" = "prepend" -o "${verb}" = "append" -o "${verb}" = "unshift" -o "${verb}" = "push" ]; then
            :
        else
            # For all verbs besides prepend and append we remove the element from the path.
            splice_debug "splice: remove ${element} from path"
            case ${path} in
                *:${element}:*)
                    while true; do
                        case "${path}" in
                            *:${element}:*)
                                splice_debug "splice: remove one occurrence of ${element} from ${path}"
                                splice_debug "   PATH=${path}"
                                path="${path%%:${element}:*}:${path#*:${element}:}"
                                splice_debug "NEWPATH=${path}"
                                ;;
                            *)
                                splice_debug "splice: done removing ${element} from ${path}"
                                break
                                ;;
                        esac
                    done
                    ;;
                *)
                    [ -t 2 ] && echo "Warning: Unable to find ${element} in path." >&2
                    path=${path%:}
                    path=${path#:}
                    echo ${path}
                    splice_debug=0
                    return 1
                    ;;
            esac
        fi

        # For all operations other than removal, make sure the thing being spliced into
        # the path actually exists.
        # If we are removing elements, then we are done.
        case ${verb} in
            remove|delete)
                continue
                ;;
            *)
                if [ ! -d ${element}/. ]; then
                    [ -t 2 ] && echo "Warning: ${element} is not a directory. Ignored." >&2
                    path=${path%:}
                    path=${path#:}
                    echo ${path}
                    splice_debug=0
                    return 2
                fi
                ;;
        esac

        # Now put the item into the path at the desired location.
        case ${verb} in
            start|prepend|unshift)
                path=:${element}${path}
                ;;
            end|append|push)
                path=${path}${element}:
                ;;
            before)
                path=${path%%:${another}:*}:${element}:${another}:${path#*:${another}:}
                ;;
            after)
                path=${path%%:${another}:*}:${another}:${element}:${path#*:${another}:}
                ;;
        esac
    done

    # Now clean up the path and either set PATH or echo the path.
    splice_debug "At end of loop: path is ${path}"

    path=$(remove_superfluous_colons "${path}")
    case ${setpath} in
        yes)
            PATH="${path}"
            ;;
        no)
            echo ${path}
            ;;
    esac
}

# pathmunge -
# A different form of splice. This does not presume
# the presence of the elements being inserted before
# or after.
pathmunge () {
    local path="${PATH}" newpath
    local verb pe
    local setpath="yes"
    # These next three are used in a swap
    local first middle last
    # N is used by shift and pop
    local n=1

    case $(verbify "$1") in
        verbose|-verbose|--verbose|debug|-debug|--debug)
            splice_debug=1
            shift
            ;;
        *)
            ;;
    esac

    # Does the user wish to build a different path?
    case "$1" in
        path|-path|--path)
            path="$2"
            setpath="no"
            shift shift
            ;;
        *)
            ;;
    esac

    path=$(remove_superfluous_colons "${path}")

    # Now add a : to the beginning and end of path for use in pattern
    # matching.
    path=":${path}:"

    # Where did we start out.
    splice_debug "pathmunge: path starts as ${path}"

    # What's our verb for action on the path?
    verb=$(verbify "$1")
    shift

    # Validate the verb
    case ${verb:-""} in
        usage|help)
            echo "Usage: pathmunge ():" >&2
            echo >&2
            echo "pathmunge adds, deletes and moves elements around in a colon-delimited path" >&2
            echo "pathmunge will insert a missing element with a move command, if it makes" >&2;
            echo "sense to be able to do so." >&2
            echo >&2
            echo "pathmunge [ verbose ] [ path initial ] [ prepend | unshift | append | push | remove | delete ] [ element+ ]" >&2
            echo "pathmunge [ verbose ] [ path initial ] [ print | show | list ]" >&2
            echo "pathmunge [ verbose ] [ path initial ] [ before | after ] [ element ] [ element+ ]" >&2
            echo "pathmunge [ verbose ] [ path initial ] [ start | end ] [ element+ ]" >&2
            echo "pathmunge [ verbose ] [ path initial ] [ swap ] [ element ] [ element ]" >&2
            echo "pathmunge [ verbose ] [ path initial ] [ shift ] [ n ]" >&2
            echo "pathmunge [ verbose ] [ path initial ] [ pop ] [ n ]" >&2
            echo "pathmunge [ verbose ] [ path initial ] [ usempi ] [ MPI-variant | list ]" >&2
            echo >&2
            echo "verbose - turn on debugging messages about what is happening in function" >&2
            echo "path - set the starting path to initial. New path is echoed to stdout" >&2
            echo "       otherwise, start with PATH and set PATH to new value." >&2
            echo "prepend,unshift - add elements one at a time to the beginning of path" >&2
            echo "append,push - add elements one at a time to the end of path" >&2
            echo "print, show, list - echo path to stdout" >&2
            echo "remove, delete - remove the elements from path" >&2
            echo "before - insert elements one at a time before the element given." >&2
            echo "after - insert elements one at a time after the element given." >&2
            echo "start - synonym for prepend." >&2;
            echo "end - synonym for append." >&2;
            echo "swap - exchange positions of two elements in path." >&2
            echo "shift - remove n items from start of path. n defaults to 1." >&2
            echo "pop - remove n items from end of path. n defaults to 1." >&2
            echo "usempi - from a list of MPI variants registered with mpi-selector" >&2
            echo "         use the requested one by prepending its paths." >&2
            echo "         If list is given, it lists the variants known to mpi-selector." >&2;
            echo >&2
            echo "All path elements must be one path element. Elements with a ':'" >&2
            echo "are ignored." >&2
            echo >&2
            echo "The current path is set to:" >&2
            path=$(remove_superfluous_colons ${path})
            echo "${path}" >&2
            splice_debug=0
            return 0
            ;;
        prepend|append|start|end|remove|delete|unshift|push)
            ;;
        usempi)
            # This is a special case to allow quick PATH switches.
            local mpiselect= mpidatadir= mpivariant= result=
            mpiselect=$(type -path mpi-selector)
            mpidatadir=$(/bin/grep 'my \$data_dir = ' ${mpiselect})
            if [ ! -n "${mpidatadir}" ]; then
                echo "Unable to find MPI selector data directory." >&2
                return 2
            fi

            mpidatadir=${mpidatadir##* \"}
            mpidatadir="${mpidatadir%\"}"
            splice_debug "mpi-selector data directory is: ${mpidatadir}"
            if cd ${mpidatadir} &> /dev/null; then
                    :
            else
                echo "Unable to cd to mpi-selector data directory." >&2
                return 1
            fi

            if [ "${1}" = "list" ]; then
                /bin/ls -C *.sh | /bin/sed -e 's@\.sh$@@g' -e 's@\.sh[[:space:]]@ @g'
                cd - &> /dev/null
                return 0
            fi

            mpivariant="${1}"
            if [ -z "${mpivariant}" ]; then
                echo "No MPI variant requested" >&2
                cd - &> /dev/null
                return 1
            fi
            splice_debug "Use requested MPI variant: ${mpivariant}"

            case ${mpivariant} in
                */*)
                    echo "No directories allowed in MPI variant" >&2
                    cd - &> /dev/null
                    return 1
                    ;;
                *)
                ;;
            esac

            if [ -f "./${mpivariant}.sh" ]; then
                splice_debug "Use MPI variant ${mpivariant}" >&2
                . ./${mpivariant}.sh
                result=0
            elif [ -f "./${mpivariant}" ]; then
                splice_debug "Use MPI variant ${mpivariant%.sh}" >&2
                . ./${mpivariant}
                result=0
            else
                echo "Unable to find requested MPI variant: ${mpivariant}" >&2
            fi
            cd - &> /dev/null
            return ${result}
            ;;
        before|after)
            if [ -z "$1" ]; then
                echo "pathmunge: before and after require a location" >&2
                splice_debug=0
                return 2
            fi
            location="$1"
            shift
            case ":${path}:" in
                *:${location}:*)
                    ;;
                *)
                    echo "pathmunge: before and after location must be in path" >&2
                    splice_debug=0
                    return 3
                    ;;
            esac
            ;;
        print|list|show)
            path=$(remove_superfluous_colons "${path}")
            echo "${path}"
            splice_debug=0
            return 0
            ;;
        shift)
            splice_debug "pathmunge: start shift. check for n argument";
            if [ $# -gt 1 ]; then
                echo "pathmunge shift takes at most one argument, n, the number of elements to remove." >&2
                return 1
            elif [ $# -eq 0 ]; then
                splice_debug "pathmunge: shift, no n supplied"
                :
            else
                case "${1}" in
                [0-9]|[0-9][0-9]|[0-9][0-9][0-9])
                    splice_debug "pathmunge: shift: set n to ${1}"
                    n="${1}"
                    shift
                    ;;
                *)
                    echo "pathmunge shift takes a non-negative numerical argument." >&2
                    shift
                    return 2
                    ;;
                esac
            fi
            splice_debug "pathmunge: shift: start while loop"
            splice_debug "pathmunge: shift: path = ${path}"
            while [ ${n} -gt 0 ]; do
                # Remember here that path has a ':' prepended and appended while working.
                case ${path} in
                :*:*:)
                    # Strip the leading ':' off, so we can pattern-match off the first element.
                    path=${path#:}
                    splice_debug "pathmunge: shift: remove first element from path: ${path%%:*}"
                    # Pull out the first element, then prepend a ':'.
                    path=${path:+:}${path#*:}
                    ;;
                *)
                    splice_debug "pathmunge: shift: remove last element from path: ${path}"
                    path=''
                    ;;
                esac
                n=$[n - 1]
            done
            splice_debug "pathmunge: shift: end with path: ${path}"
            ;;
        pop)
            splice_debug "pathmunge: start pop. check for n argument.";
            if [ $# -gt 1 ]; then
                echo "pathmunge pop takes at most one argument, n, the number of elements to remove." >&2
                return 1
            elif [ $# -eq 0 ]; then
                splice_debug "pathmunge: pop, no n supplied"
                :
            else
                case "${1}" in
                [0-9]|[0-9][0-9]|[0-9][0-9][0-9])
                    splice_debug "pathmunge: pop: set n to ${1}"
                    n="${1}"
                    shift
                    ;;
                *)
                    echo "pathmunge pop takes a non-negative numerical argument." >&2
                    shift
                    return 2
                    ;;
                esac
            fi
            splice_debug "pathmunge: pop: start while loop"
            while [ ${n} -gt 0 ]; do
                # Remember here that path has a ':' appended and prepended while working.
                case ${path} in
                :*:*:)
                    # Strip the trailing ':' off, so we can pattern match off the last element.
                    path=${path%:}
                    splice_debug "pathmunge: pop:  prune last element from path: ${path##*:}"
                    # Pull off the last element, then append a ':' again.
                    path=${path%:*}${path:+:}
                    ;;
                *)
                    splice_debug "pathmunge: pop: remove last element from path:"
                    path=''
                    ;;
                esac
                n=$[n - 1]
            done
            splice_debug "pathmunge: end pop with path: ${path}"
            ;;
        swap)
            # This one is peculiar, because it only takes two elements.
            if [ $# -ne 2 ]; then
                echo "pathmunge: swap verb takes exactly two path elements as arguments" >&2
                echo "${path}"
                splice_debug=0
                return 4
            fi

            if [ ! -d "${1}"/. ]; then
                echo "pathmunge: first path element for swap does not exist as a directory." >&2;
                echo "${path}"
                splice_debug=0
                return 5
            fi

            if [ ! -d "${2}"/. ]; then
                echo "pathmunge: second path element for swap does not exist as a directory." >&2;
                echo "${path}"
                splice_debug=0
                return 6
            fi

            splice_debug "pathmunge: swap two existing elements in path"
            case "${path}" in
                *:${1}:${2}:*|*:${1}:*:${2}:*)
                    splice_debug "splice: Case #1"
                    first="${path%%:${1}:*}"
                    middle=":${path#*:${1}:}"
                    splice_debug "splice: middle starts as ${middle}"
                    middle="${middle%:${2}:*}"
                    last="${path##*:${2}:}"
                    splice_debug "splice: first = ${first}"
                    splice_debug "splice: middle = ${middle}"
                    splice_debug "splice: last = ${last}"
                    path="${first}:${2}${middle}:${1}:${last}"
                    ;;
                *:${2}:${1}:*|*:${2}:*:${1}:*)
                    splice_debug "splice: Case #2"
                    first="${path%%:${2}:*}"
                    middle=":${path#*:${2}:}"
                    splice_debug "splice: middle starts as ${middle}"
                    middle="${middle%:${1}:*}"
                    last="${path##*:${1}:}"
                    splice_debug "pathmunge: first = ${first}"
                    splice_debug "pathmunge: middle = ${middle}"
                    splice_debug "pathmunge: last = ${last}"
                    path="${first}:${1}${middle}:${2}:${last}"
                    ;;
                *)
                    echo "Unable to find one or both path elements already in path." >&2
                    echo "${path}"
                    splice_debug=0
                    return 7
                    ;;
            esac
            shift shift
            ;;
        *)
            echo "pathmunge: Unrecognized verb ${verb}" >&2
            splice_debug=0
            return 1
            ;;
    esac

    splice_debug "pathmunge: start into path elements"
    # For each element to be acted upon:
    #   - Remove it from the path.
    #   - Reinsert it, if necessary, at the desired location.
    for pe in "$@"; do
        splice_debug "pathmunge: process pe = >${pe}<"
        # Check that the user hasn't given a chunk of path...
        case "${pe}" in
            *:*)
                echo "${pe} contains a separator :, ignoring it"
                continue
                ;;
            *)
                ;;
        esac

        # Remove all occurrences of ${pe} from path.
        while true; do
            case "${path}" in
                *:${pe}:*)
                    splice_debug "pathmunge: start removing ${pe} from ${path}"
                    splice_debug "   PATH=${path}"
                    path="${path%%:${pe}:*}:${path#*:${pe}:}"
                    splice_debug "NEWPATH=${path}"
                    ;;
                *)
                    break
                    ;;
            esac
        done
        splice_debug "pathmunge: done removing ${pe} from path"

        # If we are removing elements, then we are done with this
        # pass through the loop.
        case ${verb} in
            remove|delete)
                continue
                ;;
            *)
                ;;
        esac

        # Check to ensure that the path element exists as a directory.
        if [ ! -d "${pe}"/. ]; then
            # echo "pathmunge: directory ${pe} does not exist. removed from path" >&2
            continue
        fi

        # Put the path element into the path in the correct place.
        case ${verb} in
            start|prepend|unshift)
                splice_debug "pathmunge: prepend ${pe} onto ${path}"
                path=":${pe}${path}"
                ;;
            end|append|push)
                splice_debug "pathmunge: append ${pe} onto ${path}"
                path="${path}${pe}:"
                ;;
            before)
                splice_path "pathmunge: insert ${pe} before ${location} in ${path}"
                path="${path%%:${location}:*}:${pe}:${location}${path#*:${location}}"
                ;;
            after)
                splice_path "pathmunge: insert ${pe} after ${location} in ${path}"
                path="${path%%:${location}:*}:${location}:${pe}${path#*:${location}}"
                ;;
        esac
    done

    # Cleanup and either echo the new path or set PATH.
    path=$(remove_superfluous_colons "${path}")

    case "${setpath}" in
        yes)
            PATH="${path}"
            ;;
        no)
            echo "${path}"
            ;;
    esac
}


# This is a short-circuit for when we are sourcing this file.
# Remove this to run it as an executable.
splice_debug=0
return 0 &> /dev/null

# Check to see how we got here.
# Were we sourced or exec'd?
PROG="${0##*/}"
PROG="${0%.new}"
PROG="${0%.sh}"
PROG="${0%.bash}"
case "${PROG}" in
    *splice*)
        func=splice
        ;;
    *)
        func=pathmunge
        ;;
esac

case "$@" in
    *path\ *)
        p=''
        ;;
    *)
        p="path ${PATH}"
        ;;
esac

# echo "\$0 is $0"
case ${0} in
    *.bash|*.sh)
        ${func} ${p}${p:+ }"$@"
        # echo ${PATH}
        ;;
    *bash)
        ;;
    *)
        ${func} ${p}${p:+ }"$@"
        # echo ${PATH}
        ;;
esac
