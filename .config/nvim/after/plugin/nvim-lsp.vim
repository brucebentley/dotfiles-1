lua << END
require'nvim_lsp'.clangd.setup{}
END

function s:SetUpLspHighlights()
	execute 'highlight LspDiagnosticsError ' . pinnacle#decorate('italic', 'WarningMsg')
	execute 'highlight LspDiagnosticsHint ' . pinnacle#decorate('italic', 'ModeMsg')
	execute 'highlight LspDiagnosticsInformation ' . pinnacle#decorate('italic', 'Conditional')
	execute 'highlight LspDiagnosticsWarning ' . pinnacle#decorate('italic', 'Type')

	execute 'highlight LspDiagnosticsErrorSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('WarningMsg')
				\ })

	execute 'highlight LspDiagnosticsHintSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('ModeMsg')
				\ })

	execute 'highlight LspDiagnosticsInformationSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('Conditional'),
				\ })

	execute 'highlight LspDiagnosticsWarningSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('Type')
				\ })
endfunction

sign define LspDiagnosticsErrorSign text=✖
sign define LspDiagnosticsWarningSign text=
sign define LspDiagnosticsInformationSign text=
sign define LspDiagnosticsHintSign text=➤

if has('autocmd')
	augroup EmanonLanguageClientAutocmds
		autocmd!
		autocmd ColorScheme * call s:SetUpLspHighlights()
	augroup END
endif

call s:SetUpLspHighlights()
