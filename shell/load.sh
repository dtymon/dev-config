# Source shared environment
for f in "$DEVENV_SHELL"/common/*.sh; do
    source "$f"
done

# Source the organisation related configuration
if [[ -f "$DEVENV_SHELL/org.sh" ]]; then
    source "$DEVENV_SHELL/org.sh"
    if [ -n "$dtymon_ORGANISATION" -a -d "$DEVENV_SHELL/org/$dtymon_ORGANISATION" ]; then
        for f in "$DEVENV_SHELL/org/$dtymon_ORGANISATION"/*.sh; do
            source "$f"
        done
    fi
fi
