#/bin/bash

PREV_CC="8080"
CC_PRESENT=0
while IFS="=" read KEY VALUE ; dos
    if [[ -n "${CC_HEX}" ]] ; then
        CC="${CC_HEX:2:4}"
        if { [[ "${CC}" != "8080" ]] && [[ "${PREV_CC}" == "8080" ]] ; } || { [[ "${CC}" == "9420" ]] && [[ "${PREV_CC}" != "9420" ]] ; } ; then
            _write_new_cc_line
            _write_cc "$CC"
        elif [[ "${CC}" != "8080" ]] ; then
            _write_cc "$CC"
        fi
        PREV_CC="$CC"
        if [[ "$CC_PRESENT" == 0 ]] ; then
            CC_PRESENT=1
            if [[ -n "${CC_LOG}" ]] ; then
                TRANSITION_TIME="$(_hhmmssmmm_to_hhmmssff "${SECS}")"
                _report -d "${CC_LOG} - ${TRANSITION_TIME}."
            fi
            TRANSITION_TIME="$(_hhmmssmmm_to_hhmmssff "${SECS}")"
            CC_LOG="Caption data  ON: ${TRANSITION_TIME}"
        fi
    else
        if [[ "$CC_PRESENT" == 1 ]] ; then
            CC_PRESENT=0
            if [[ -n "${CC_LOG}" ]] ; then
                TRANSITION_TIME="$(_hhmmssmmm_to_hhmmssff "${SECS}")"
                _report -d "${CC_LOG} - ${TRANSITION_TIME}."
            fi
            TRANSITION_TIME="$(_hhmmssmmm_to_hhmmssff "${SECS}")"
            CC_LOG="Caption data OFF: ${TRANSITION_TIME}"
        fi
        PREV_CC="8080"
    fi
    PREV_SECS="$SECS"
done < <(grep -o "pts_time:[^ ]*\|lavfi.readeia608.0.cc=[^ ]*"  /Users/daverice/Desktop/vrecord_tests/TEST9954_ffv1_frame_eia608data.txt)