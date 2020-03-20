# On slow systems, checking the cached .zcompdump file to see if it must be 
  # regenerated adds a noticable delay to zsh startup.  This little hack restricts 
  # it to once a day.  It should be pasted into your own completion file.
  #
  # The globbing is a little complicated here:
  # - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
  # - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
  # - '.' matches "regular files"
  # - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
  #speed up load time
  DISABLE_UPDATE_PROMPT=true

  # Perform compinit only once a day
  # autoload -Uz compinit

  # setopt EXTENDEDGLOB
  # for dump in $ZSH_COMPDUMP(#qN.m1); do
  #   compinit
  #   if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
  #     zcompile "$dump"
  #   fi
  # done
  # unsetopt EXTENDEDGLOB
  # compinit -C

  zstyle ':compinstall' filename '~/.zshrc'
   
  _update_zcomp() {
    setopt local_options
    setopt extendedglob
    autoload -Uz compinit
    local zcompf="$1/zcompdump"

    if [[ -e "$zcompf_a" && -f "$zcompf_a"(#qN.md-1) ]]; then
      compinit -C -d "$zcompf"
    else
      compinit -d "$zcompf"
    fi
    # if zcompdump exists (and is non-zero), and is older than the .zwc file,
      # then regenerate
        if [[ -s "$zcompf" && (! -s "${zcompf}.zwc" || "$zcompf" -nt "${zcompf}.zwc") ]]; then
          # since file is mapped, it might be mapped right now (current shells), so
          # rename it then make a new one
            [[ -e "$zcompf.zwc" ]] && mv -f "$zcompf.zwc" "$zcompf.zwc.old"
            # compile it mapped, so multiple shells can share it (total mem reduction)
            # run in background
            zcompile -M "$zcompf" &!
          fi
        }
      _update_zcomp "$zcachedir"
      unfunction _update_zcomp