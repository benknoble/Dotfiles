#! /usr/bin/env bash

# This shell script contains two different major path munging functions:
# pathmunge

# This function take the following verbs
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

# pathmunge - This does not presume the presence of the elements being inserted
# before or after.
pathmunge () {

  log() {
    printf '%s\n' "$@" >&2
  }

  splice_debug() {
    if (( splice_debug != 0 )) ; then
      log "$@"
    fi
  }

  remove_superfluous_colons () {
    local path="$1"

    # Remove superfluous : characters from path.
    # First remove the ones from the beginning.
    # Second remove ones from the end.
    # Third remove double colons from the middle.
    if [[ $path =~ :*(.*) ]]; then
      path="${BASH_REMATCH[1]}"
    fi
    if [[ $path =~ (.*):* ]]; then
      path="${BASH_REMATCH[1]}"
    fi

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

    printf '%s\n' "${path}"
  }

  # verbs in this script can take zero, one or two leading dashes.
  verbify () {
    local verb="$1"
    if [[ $verb =~ -{0,2}(.*) ]]; then
      verb="${BASH_REMATCH[1]}"
    fi
    printf '%s\n' "${verb}"
  }

  usage () {
    log "Usage: pathmunge

pathmunge adds, deletes and moves elements around in a colon-delimited path
pathmunge will insert a missing element with a move command, if it makes;
sense to be able to do so.

pathmunge [ verbose ] [ path initial ] [ prepend | unshift | append | push | remove | delete ] [ element+ ]
pathmunge [ verbose ] [ path initial ] [ print | show | list ]
pathmunge [ verbose ] [ path initial ] [ before | after ] [ element ] [ element+ ]
pathmunge [ verbose ] [ path initial ] [ start | end ] [ element+ ]
pathmunge [ verbose ] [ path initial ] [ swap ] [ element ] [ element ]
pathmunge [ verbose ] [ path initial ] [ shift ] [ n ]
pathmunge [ verbose ] [ path initial ] [ pop ] [ n ]

verbose - turn on debugging messages about what is happening in function
path - set the starting path to initial. New path is echoed to stdout
        otherwise, start with PATH and set PATH to new value.
prepend,unshift - add elements one at a time to the beginning of path
append,push - add elements one at a time to the end of path
print, show, list - echo path to stdout
remove, delete - remove the elements from path
before - insert elements one at a time before the element given.
after - insert elements one at a time after the element given.
start - synonym for prepend.;
end - synonym for append.;
swap - exchange positions of two elements in path.
shift - remove n items from start of path. n defaults to 1.
pop - remove n items from end of path. n defaults to 1.

All path elements must be one path element. Elements with a ':'
are ignored."
  }

  local splice_debug=0
  local path="${PATH}"
  local verb pe
  local setpath="yes"
  # These next three are used in a swap
  local first middle last
  # N is used by shift and pop
  local n=1

  case "$(verbify "$1")" in
    verbose|debug)
      splice_debug=1
      shift
      ;;
    *)
      ;;
  esac

  case "$1" in
    path)
      path="$2"
      setpath="no"
      shift 2
      ;;
    *)
      ;;
  esac

  path="$(remove_superfluous_colons "${path}")"
  # Now add a : to the beginning and end of path for use in pattern
  # matching.
  path=":${path}:"

  # Where did we start out.
  splice_debug "pathmunge: path starts as ${path}"

  # What's our verb for action on the path?
  verb="$(verbify "$1")"
  shift

  # Validate the verb
  case "${verb:-''}" in
    usage|help)
      usage
      echo "The current path is set to:" >&2
      path="$(remove_superfluous_colons "${path}")"
      echo "${path}" >&2
      splice_debug=0
      return 0
      ;;
    prepend|append|start|end|remove|delete|unshift|push)
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
        *:"${location}":*)
          ;;
        *)
          echo "pathmunge: before and after location must be in path" >&2
          splice_debug=0
          return 3
          ;;
      esac
      ;;
    print|list|show)
      path="$(remove_superfluous_colons "${path}")"
      echo "${path}"
      splice_debug=0
      return 0
      ;;
    shift)
      splice_debug "pathmunge: start shift. check for n argument";
      if [[ $# -gt 1 ]]; then
        echo "pathmunge shift takes at most one argument, n, the number of elements to remove." >&2
        return 1
      elif [[ $# -eq 0 ]]; then
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
      while (( n > 0 )); do
        # Remember here that path has a ':' prepended and appended while working.
        case "${path}" in
          :*:*:)
            # Strip the leading ':' off, so we can pattern-match off the first element.
            path="${path#:}"
            splice_debug "pathmunge: shift: remove first element from path: ${path%%:*}"
            # Pull out the first element, then prepend a ':'.
            path="${path:+:}${path#*:}"
            ;;
          *)
            splice_debug "pathmunge: shift: remove last element from path: ${path}"
            path=''
            ;;
        esac
        (( n-- ))
      done
      splice_debug "pathmunge: shift: end with path: ${path}"
      ;;
    pop)
      splice_debug "pathmunge: start pop. check for n argument.";
      if [[ $# -gt 1 ]]; then
        echo "pathmunge pop takes at most one argument, n, the number of elements to remove." >&2
        return 1
      elif [[ $# -eq 0 ]]; then
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
      while (( n > 0 )); do
        # Remember here that path has a ':' appended and prepended while working.
        case "${path}" in
          :*:*:)
            # Strip the trailing ':' off, so we can pattern match off the last element.
            path="${path%:}"
            splice_debug "pathmunge: pop:  prune last element from path: ${path##*:}"
            # Pull off the last element, then append a ':' again.
            path="${path%:*}${path:+:}"
            ;;
          *)
            splice_debug "pathmunge: pop: remove last element from path:"
            path=''
            ;;
        esac
        (( n-- ))
      done
      splice_debug "pathmunge: end pop with path: ${path}"
      ;;
    swap)
      # This one is peculiar, because it only takes two elements.
      if [[ $# -ne 2 ]]; then
        echo "pathmunge: swap verb takes exactly two path elements as arguments" >&2
        echo "${path}"
        splice_debug=0
        return 4
      fi

      if [[ ! -d "${1}"/. ]]; then
        echo "pathmunge: first path element for swap does not exist as a directory." >&2;
        echo "${path}"
        splice_debug=0
        return 5
      fi

      if [[ ! -d "${2}"/. ]]; then
        echo "pathmunge: second path element for swap does not exist as a directory." >&2;
        echo "${path}"
        splice_debug=0
        return 6
      fi

      splice_debug "pathmunge: swap two existing elements in path"
      case "${path}" in
        *:"${1}":"${2}":*|*:"${1}":*:"${2}":*)
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
        *:"${2}":"${1}":*|*:"${2}":*:"${1}":*)
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
        *:"${pe}":*)
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
    case "${verb}" in
      remove|delete)
        continue
        ;;
      *)
        ;;
    esac

    # Check to ensure that the path element exists as a directory.
    if [[ ! -d "${pe}"/. ]]; then
      # echo "pathmunge: directory ${pe} does not exist. removed from path" >&2
      continue
    fi

    # Put the path element into the path in the correct place.
    case "${verb}" in
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
  path="$(remove_superfluous_colons "${path}")"

  case "${setpath}" in
    yes)
      PATH="${path}"
      ;;
    no)
      echo "${path}"
      ;;
  esac
}
