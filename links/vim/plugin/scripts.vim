if exists('g:scripts_loaded')
  finish
endif
let g:scripts_loaded = 1

command -bar -nargs=* -complete=dir RtpAdd exec scripts#rtp_add_command(<f-args>)
command -bar -nargs=* -complete=dir RtpRm exec scripts#rtp_rm_command(<f-args>)
