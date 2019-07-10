if exists('g:scripts_loaded')
  finish
endif
let g:scripts_loaded = 1

command -bar -nargs=* -complete=file RtpAdd exec scripts#rtp_add_command(<f-args>)
command -bar -nargs=* -complete=file RtpRm exec scripts#rtp_rm_command(<f-args>)
