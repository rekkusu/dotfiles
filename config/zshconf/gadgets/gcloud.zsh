
() {
    function gcloud_arch() {
        if [[ -e /opt/google-cloud-cli ]]; then
            source /opt/google-cloud-cli/path.zsh.inc
            source /opt/google-cloud-cli/completion.zsh.inc
        fi
    }

    if [[ -f /etc/os-release ]]; then
        local id=$(grep "^ID=" /etc/os-release | cut -d '=' -f 2 | tr -d '"')
        case $id in
            arch ) gcloud_arch;;
            * ) ;;
        esac
    fi
}
